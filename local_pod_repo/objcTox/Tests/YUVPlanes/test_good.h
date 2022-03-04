// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

uint8_t test_good_y[] = {
    204, 201, 199, 198, 197, 197, 196, 196, 195, 195, 194, 176, 189, 191, 206, 206, 204, 206, 195, 197, 198, 199, 199, 200, 200, 200, 187, 193, 199, 199,
    200, 199, 199, 198, 198, 196, 196, 195, 195, 195, 180, 179, 196, 198, 204, 201, 209, 210, 194, 197, 197, 198, 199, 199, 199, 199, 181, 187, 198, 197,
    205, 201, 200, 199, 199, 198, 198, 197, 196, 192, 178, 195, 198, 201, 205, 204, 191, 195, 198, 198, 199, 199, 199, 200, 200, 200, 190, 191, 198, 200,
    207, 203, 202,  56,  56, 200, 199, 199, 199, 181, 184, 197, 199, 202, 206, 205, 196, 199, 199, 183, 182, 200, 201, 202, 201, 200, 195, 195, 199, 200,
    208, 204,  59, 202, 202,  56, 200, 200, 195, 169, 193, 199, 200, 199, 206, 206, 198, 200, 201, 154, 174, 201, 202, 202, 202, 201, 192, 184, 200, 196,
    208, 205,  58, 203, 202,  56, 200, 200, 181, 186, 199, 199, 202, 203, 208, 207, 197, 200, 189, 155, 187, 201, 201, 202, 201, 201, 187, 171, 199, 188,
    208, 204,  59, 203, 202,  56, 201, 194, 185, 199, 190, 199, 201, 202, 207, 206, 197, 200, 179, 174, 180, 201, 201, 201, 200, 201, 193, 167, 188, 171,
    207, 204,  58, 203, 202,  56, 200, 185, 193, 176, 185, 198, 200, 200, 206, 205, 198, 181, 163, 184, 175, 193, 200, 201, 198, 196, 198, 159, 184, 183,
    207, 204, 203,  57,  56, 201, 200, 192, 178, 169, 199, 198, 201, 203, 207, 201, 184, 165, 172, 194, 179, 170, 196, 201, 198, 192, 200, 171, 178, 199,
    208, 204, 203, 203, 202, 201, 197, 184, 177, 190, 199, 192, 192, 201, 207, 199, 189, 174, 196, 200, 194, 161, 177, 201, 199, 178, 181, 192, 158, 180,
    208, 204,  59, 203, 202,  56, 196, 179, 172, 186, 199, 187, 191, 201, 207, 206, 178, 180, 200, 200, 200, 182, 148, 190, 200, 173, 154, 194, 168, 159,
    208, 204,  58, 203,  57, 201, 194, 184, 169, 185, 199, 192, 197, 202, 207, 200, 185, 190, 187, 200, 200, 200, 147, 168, 200, 187, 154, 180, 162, 107,
    208, 204,  58,  57, 202, 201, 188, 177, 179, 198, 199, 198, 200, 200, 196, 196, 165, 126, 147, 140, 171, 200, 169, 139, 197, 200, 151, 164, 151, 132,
    207, 204,  58, 202,  57, 200, 195, 191, 182, 189, 198, 188, 194, 201, 207, 137, 117, 159, 122,  91, 165, 200, 198, 165, 171, 182, 158, 162, 215, 116,
    209, 205,  60, 203, 203,  57, 201, 200, 174, 166, 200, 177, 177, 202, 196, 113, 180, 120,  56, 109, 201, 201, 201, 202, 193, 166, 133, 184, 160,  65,
    216, 212, 213, 212, 210, 211, 210, 208, 182, 168, 208, 179, 158, 206, 181, 148, 179,  66,  69, 129, 200, 208, 207, 209, 208, 202, 167, 170, 148,  62,
    209, 206,  60, 204,  58, 203, 202, 201, 176, 157, 200, 181, 137, 198, 200, 154, 160, 106,  61,  60, 136, 206, 206, 207, 207, 204, 205, 198, 199,  94,
    207, 204,  58, 203,  56, 201, 200, 200, 185, 146, 182, 193, 132, 185, 206, 146, 174, 178,  85,  75, 147, 203, 204, 204, 203, 201, 201, 202, 186, 130,
    208, 205,  59, 203,  57, 202, 201, 201, 195, 161, 178, 181, 150, 131, 190, 171, 168, 178, 145, 179, 195, 199, 200, 199, 199, 199, 197, 196, 193, 169,
    208, 205, 204, 203, 203, 202, 201, 200, 200, 189, 188, 174, 125, 138, 187, 156, 170, 192, 166, 191, 200, 201, 201, 201, 200, 199, 199, 198, 198, 196,
    207, 204,  59, 203,  58, 201, 201, 201, 200, 187, 173, 200, 146, 153, 207, 160, 172, 199, 179, 198, 200, 201, 197, 184, 198, 200, 199, 198, 198, 188,
    202, 201, 201, 202, 201, 200, 201, 201, 201, 178, 165, 200, 160, 168, 199, 188, 167, 173, 173, 186, 198, 201, 198, 183, 197, 200, 199, 198, 172, 157,
    194, 195, 196, 196, 198, 203, 202, 200, 201, 180, 168, 200, 153, 177, 198, 175, 170, 167, 168, 179, 200, 201, 202, 202, 201, 200, 199, 198, 181, 176,
    195, 191, 193, 195, 204, 203, 196, 197, 201, 183, 171, 200, 153, 165, 207, 183, 196, 196, 195, 201, 202, 202, 202, 202, 201, 201, 200, 199, 198, 199,
    209, 201, 200, 205, 203, 189, 187, 193, 201, 174, 171, 202, 157, 160, 208, 176, 199, 202, 202, 202, 202, 195, 183, 194, 198, 196, 189, 182, 178, 192,
    207, 208, 207, 206, 194, 182, 185, 186, 194, 171, 175, 203, 161, 148, 208, 171, 166, 203, 203, 203, 203, 197, 184, 186, 189, 189, 186, 188, 197, 201,
    202, 209, 208, 203, 190, 190, 180, 182, 199, 174, 176, 197, 160, 146, 193, 200, 167, 185, 204, 204, 204, 204, 205, 205, 205, 203, 203, 202, 201, 201,
    213, 211, 211, 209, 184, 181, 195, 196, 194, 179, 176, 196, 172, 155, 187, 211, 201, 167, 163, 176, 204, 206, 206, 206, 206, 205, 204, 203, 203, 147,
    214, 188, 184, 204, 211, 182, 208, 208, 181, 180, 176, 200, 168, 181, 188, 211, 194, 181, 168, 145, 154, 181, 195, 208, 207, 206, 198, 148,  86, 112,
    186, 173, 174, 174, 203, 211, 196, 188, 188, 182, 168, 203, 171, 180, 210, 194, 190, 173, 179, 194, 191, 160, 125, 129, 171, 146,  76,  61, 128, 205,
};

uint8_t test_good_uv[] = {
    104, 164, 105, 166, 105, 167, 106, 168, 111, 168, 117, 169, 124, 169, 130, 162, 135, 160, 143, 168, 150, 167, 156, 166, 158, 166, 158, 166, 158, 167,
    103, 163, 103, 164, 103, 165, 104, 167, 109, 167, 115, 167, 122, 166, 128, 162, 136, 169, 142, 167, 149, 166, 156, 165, 157, 166, 158, 166, 158, 166,
    102, 159, 102, 161, 102, 162, 103, 163, 108, 164, 113, 164, 121, 162, 127, 159, 134, 165, 141, 163, 148, 163, 155, 163, 157, 163, 157, 164, 158, 164,
    101, 152, 101, 154, 101, 155, 103, 156, 108, 157, 114, 157, 121, 156, 127, 153, 134, 157, 141, 156, 148, 156, 155, 155, 157, 157, 158, 157, 158, 158,
    101, 145, 101, 147, 101, 148, 103, 149, 108, 150, 114, 150, 121, 149, 127, 147, 134, 150, 141, 150, 148, 150, 155, 149, 157, 150, 158, 151, 158, 151,
    101, 139, 101, 140, 102, 141, 102, 142, 107, 143, 114, 143, 120, 142, 128, 141, 135, 143, 141, 143, 148, 143, 155, 142, 157, 143, 158, 144, 159, 145,
    101, 132, 100, 133, 101, 135, 103, 135, 107, 136, 113, 136, 120, 136, 127, 135, 134, 136, 141, 136, 148, 136, 155, 136, 158, 137, 158, 137, 156, 137,
    103, 126, 104, 127, 104, 128, 105, 129, 109, 129, 114, 129, 121, 129, 127, 129, 134, 129, 141, 129, 147, 129, 153, 129, 155, 129, 156, 131, 151, 131,
    101, 119, 102, 120, 102, 121, 103, 122, 107, 122, 114, 122, 120, 123, 127, 123, 134, 123, 140, 123, 146, 123, 153, 122, 155, 124, 155, 124, 157, 125,
    101, 112, 101, 113, 102, 114, 103, 115, 108, 116, 113, 116, 120, 115, 127, 117, 134, 115, 142, 116, 148, 116, 156, 116, 158, 117, 159, 118, 159, 118,
    101, 105, 102, 106, 102, 108, 103, 108, 108, 109, 114, 109, 120, 109, 127, 111, 134, 109, 141, 109, 148, 110, 155, 110, 158, 110, 158, 112, 158, 112,
    101, 100, 102, 101, 102, 101, 103, 103, 108, 103, 113, 103, 120, 103, 127, 106, 134, 103, 141, 104, 148, 103, 155, 104, 157, 105, 158, 105, 158, 107,
    101,  95, 101,  95, 102,  96, 103,  97, 107,  98, 112,  97, 120,  97, 127, 102, 134,  98, 140,  98, 147,  99, 154,  99, 156, 100, 157, 101, 157, 103,
    100,  92, 101,  92, 101,  94, 102,  94, 107,  94, 112,  95, 118,  94, 125,  99, 131,  94, 139,  95, 146,  96, 152,  96, 155,  97, 156,  98, 156,  99,
    99,  90,  99,  91,  99,  91, 101,  92, 105,  92, 110,  93, 117,  92, 124,  97, 130,  93, 137,  94, 144,  95, 151,  95, 153,  96, 154,  97, 155,  98,
};
