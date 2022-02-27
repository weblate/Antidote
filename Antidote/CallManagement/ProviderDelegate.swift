//
//  ProviderDelegate.swift
//  Hotline
//
//  Created by Steve Baker on 10/27/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import AVFoundation
import CallKit

class ProviderDelegate: NSObject {

    fileprivate let callManager: CallManager
    fileprivate let provider: CXProvider

    init(callManager: CallManager) {
        self.callManager = callManager
        provider = CXProvider(configuration: type(of: self).providerConfiguration)

        super.init()

        provider.setDelegate(self, queue: nil)
    }

    // static var belongs to the type
    // subclasses can't override static
    static var providerConfiguration: CXProviderConfiguration {
        // initialize
        let providerConfiguration = CXProviderConfiguration(localizedName: "Antidote")

        // set call capabilities
        providerConfiguration.supportsVideo = true
        providerConfiguration.maximumCallsPerCallGroup = 2 // Signal Messenger seems to think 2 is needed
        providerConfiguration.supportedHandleTypes = [.generic]

        return providerConfiguration
    }
    
    func endIncomingCalls() {
        
        print("cc2:endIncomingCalls")
        
        for call in callManager.calls {
            print("cc2:endcall %@", call)
            provider.reportCall(with: call.uuid, endedAt: Date(), reason: .remoteEnded)
            call.end()
        }

        callManager.removeAllCalls()
    }

    func reportIncomingCall(uuid: UUID, handle: String, hasVideo: Bool = false, completion: ((NSError?) -> Void)?) {

        // prepare update to send to system
        let update = CXCallUpdate()
        // add call metadata
        update.remoteHandle = CXHandle(type: .generic, value: handle)
        update.hasVideo = hasVideo

        // use provider to notify system
        provider.reportNewIncomingCall(with: uuid, update: update) { error in

            // now we are inside reportNewIncomingCall's final argument, a completion block
            if error == nil {
                // no error, so add call
                let call = Call(uuid: uuid, handle: handle)
                self.callManager.add(call: call)
            }

            // execute "completion", the final argument that was passed to outer method reportIncomingCall
            // execute if it isn't nil
            completion?(error as NSError?)
        }
    }

}

extension ProviderDelegate: CXProviderDelegate {

    func providerDidReset(_ provider: CXProvider) {
        // stopAudio()

        for call in callManager.calls {
            call.end()
        }

        callManager.removeAllCalls()
    }

    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        // startAudio()
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {

        print("cc2:call-answer %@", action)
        
        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        // also answer Tox Call -------------
        // -- HaXX0r --
        // -- HaXX0r --
        // -- HaXX0r --
        let coord = AppDelegate.shared.coordinator.activeCoordinator
        let runcoord = coord as! RunningCoordinator
        runcoord.activeSessionCoordinator?.callCoordinator.answerCall(enableVideo: false)
        // -- HaXX0r --
        // -- HaXX0r --
        // -- HaXX0r --
        // also answer Tox Call -------------

        // configureAudioSession()
        call.answer()
        // when processing an action, app should fulfill it or fail
        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {

        print("cc2:call-end %@", action)

        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        // also decline Tox Call -------------
        // -- HaXX0r --
        // -- HaXX0r --
        // -- HaXX0r --
        let coord = AppDelegate.shared.coordinator.activeCoordinator
        let runcoord = coord as! RunningCoordinator
        runcoord.activeSessionCoordinator?.callCoordinator.declineCall(callWasRemoved: false)
        // -- HaXX0r --
        // -- HaXX0r --
        // -- HaXX0r --
        // also decline Tox Call -------------

        // stopAudio()
        // call.end changes the call's status, allows other classes to react to new state
        call.end()
        action.fulfill()
        callManager.remove(call: call)
    }

    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {

        print("cc2:call-held %@", action)

        guard let call = callManager.callWithUUID(uuid: action.callUUID) else {
            action.fail()
            return
        }

        call.state = action.isOnHold ? .held : .active

        if call.state == .held {
            // stopAudio()
        } else {
            // startAudio()
        }

        action.fulfill()
    }

    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        let call = Call(uuid: action.callUUID, outgoing: true, handle: action.handle.value)
        // configure. provider(_:didActivate) will start audio
        // configureAudioSession()
        
        print("cc2:call-start %s", action.handle.value)

        // set connectedStateChanged as a closure to monitor call lifecycle
        call.connectedStateChanged = { [weak self, weak call] in
            guard let strongSelf = self, let call = call else { return }

            if call.connectedState == .pending {
                strongSelf.provider.reportOutgoingCall(with: call.uuid, startedConnectingAt: nil)
            } else if call.connectedState == .complete {
                strongSelf.provider.reportOutgoingCall(with: call.uuid, connectedAt: nil)
            }
        }

        call.start { [weak self, weak call] success in
            guard let strongSelf = self, let call = call else { return }

            if success {
                action.fulfill()
                strongSelf.callManager.add(call: call)
            } else {
                action.fail()
            }
        }
    }

}