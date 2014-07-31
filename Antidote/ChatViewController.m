//
//  ChatViewController.m
//  Antidote
//
//  Created by Dmitry Vorobyov on 27.07.14.
//  Copyright (c) 2014 dvor. All rights reserved.
//

#import "ChatViewController.h"
#import "UIViewController+Utilities.h"
#import "ChatIncomingCell.h"
#import "ChatInputView.h"
#import "CoreDataManager+Message.h"
#import "ToxManager.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, ChatInputViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ChatInputView *inputView;

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) CDChat *chat;

@property (assign, nonatomic) BOOL didLayousSubviewsForFirstTime;

@end

@implementation ChatViewController

#pragma mark -  Lifecycle

- (instancetype)initWithChat:(CDChat *)chat;
{
    self = [super init];

    if (self) {
        self.chat = chat;

        self.hidesBottomBarWhenPushed = YES;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(newMessageNotification:)
                                                     name:kCoreDataManagerNewMessageNotification
                                                   object:nil];
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [self loadWhiteView];

    [self createTableView];
    [self createRecognizers];
    [self createInputView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.messages = [NSMutableArray arrayWithArray:[CoreDataManager messagesForChat:self.chat]];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if (! self.didLayousSubviewsForFirstTime) {
        self.didLayousSubviewsForFirstTime = YES;

        [self adjustSubviews];
        [self scrollToBottomAnimated:NO];
    }
}

#pragma mark -  Gestures

- (void)tableViewTapGesture:(UITapGestureRecognizer *)tapGR
{
    [self.inputView resignFirstResponder];
}

#pragma mark -  UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatIncomingCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChatIncomingCell reuseIdentifier]
                                                             forIndexPath:indexPath];

    CDMessage *message = self.messages[indexPath.row];

    cell.textLabel.text = message.text;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark -  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -  ChatInputViewDelegate

- (void)chatInputViewWantsToUpdateFrame:(ChatInputView *)view
{

}

- (void)chatInputView:(ChatInputView *)view sendButtonPressedWithText:(NSString *)text;
{
    [[ToxManager sharedInstance] sendMessage:text toChat:self.chat];
}

#pragma mark -  Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [self changeTableViewBottomInsetTo:self.inputView.frame.size.height + keyboardRect.size.height
                 withAnimationDuration:duration];
    [self moveInputViewToBelowTableWithAnimationDuration:duration];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [self changeTableViewBottomInsetTo:self.inputView.frame.size.height
                 withAnimationDuration:duration];
    [self moveInputViewToBelowTableWithAnimationDuration:duration];
}

- (void)newMessageNotification:(NSNotification *)notification
{
    CDMessage *message = notification.userInfo[kCoreDataManagerNewMessageKey];

    if (! [message.chat isEqual:self.chat]) {
        return;
    }

    NSIndexPath *lastMessagePath;

    if (self.messages.count) {
        lastMessagePath = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];
    }

    [self.messages addObject:message];

    @synchronized(self.tableView) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];

        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }

    // scroll to bottom only if last message was visible
    if (lastMessagePath) {
        CGRect rect = CGRectZero;
        rect.origin = self.tableView.contentOffset;
        rect.size = self.tableView.frame.size;
        rect.size.height -= self.tableView.contentInset.bottom;

        NSArray *visiblePathes = [self.tableView indexPathsForRowsInRect:rect];

        if ([visiblePathes containsObject:lastMessagePath]) {
            [self scrollToBottomAnimated:YES];
        }
    }
}

#pragma mark -  Private

- (void)createTableView
{
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[ChatIncomingCell class] forCellReuseIdentifier:[ChatIncomingCell reuseIdentifier]];

    [self.view addSubview:self.tableView];
}

- (void)createRecognizers
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tableViewTapGesture:)];

    [self.tableView addGestureRecognizer:tapGR];
}

- (void)createInputView
{
    self.inputView = [ChatInputView new];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
}

- (void)adjustSubviews
{
    const CGFloat inputViewHeight = [self.inputView heightWithCurrentText];

    {
        self.tableView.frame = self.view.bounds;

        [self changeTableViewBottomInsetTo:inputViewHeight withAnimationDuration:0.0];
    }

    {
        CGRect frame = CGRectZero;
        frame.size.width = self.view.bounds.size.width;
        frame.size.height = inputViewHeight;
        self.inputView.frame = frame;

        [self moveInputViewToBelowTableWithAnimationDuration:0.0];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count-1 inSection:0];

    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)changeTableViewBottomInsetTo:(CGFloat)new withAnimationDuration:(NSTimeInterval)duration
{
    const CGFloat old = self.tableView.contentInset.bottom;

    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom = new;
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;

        if (new > old) {
            CGPoint offset = self.tableView.contentOffset;

            const CGFloat visibleHeight = self.tableView.frame.size.height - insets.top - insets.bottom;
            if (self.tableView.contentSize.height < visibleHeight) {
                // don't change offset
                return;
            }

            offset.y += (new - old);

            if (offset.y < 0.0) {
                offset.y = 0.0;
            }

            [self.tableView setContentOffset:offset animated:NO];
        }
    }];
}

- (void)moveInputViewToBelowTableWithAnimationDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.inputView.frame;

        frame.origin.y = self.tableView.frame.size.height -
            self.tableView.contentInset.bottom;

        self.inputView.frame = frame;
    }];
}

@end