//
//  main.m
//  encode
//
//  Created by beyond on 16/4/2.
//  Copyright (c) 2016年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import "GTMDefines.h"






int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *picFolderPath = @"/Users/beyond/Desktop/tmp_tai_pic";
        NSArray *shortPicNameArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:picFolderPath error:nil];
        NSLog(@"arr:%@",shortPicNameArr);
        
        for (NSString *shortPicName in shortPicNameArr) {
            // /Users/beyond/Desktop/tmp_tai_pic/9.png
            NSString *fullPicPath = [picFolderPath stringByAppendingPathComponent:shortPicName];
            NSLog(@"fullPicPath:%@",fullPicPath);
            // 读原始数据
            NSData *imageDataOrigin = [NSData dataWithContentsOfFile:fullPicPath];
            
            // 对前1000位进行异或处理
            unsigned char * cByte = (unsigned char*)[imageDataOrigin bytes];
            for (int index = 0; (index < [imageDataOrigin length]) && (index < kEncodeKeyLength); index++, cByte++)
            {
                *cByte = (*cByte) ^ arrayForEncode[index];
            }
            
            //对NSData进行base64编码
            NSData *imageDataEncode = [GTMBase64 encodeData:imageDataOrigin];
            
            
            
            // /Users/beyond/Desktop/tmp_tai_pic/encode_9.png
            NSString *newShortPicName = [NSString stringWithFormat:@"encode_%@",shortPicName];
            NSString *newFullPicPath = [picFolderPath stringByAppendingPathComponent:newShortPicName];
            NSLog(@"fullPicPath:%@",fullPicPath);
            
            [imageDataEncode writeToFile:newFullPicPath atomically:YES];
            
            
            
        }
        
        
    }
    return 0;
}


/*
//下面是解密过程
// 未进行加密前,使用的是 1.gif
//    cell.xib_imgView.image = [UIImage imageNamed:imgName];




// 进行了加密后,根据data生成图片
NSString *newImgName = [NSString stringWithFormat:@"encode_%@",imgName];
NSString *filePath = [[NSBundle mainBundle]pathForResource:newImgName ofType:nil];
// 读取被加密文件对应的数据
NSData *dataEncoded = [NSData dataWithContentsOfFile:filePath];
// 对NSData进行base64解码
NSData *dataDecode = [GTMBase64 decodeData:dataEncoded];


// 对前1000位进行异或处理
unsigned char * cByte = (unsigned char*)[dataDecode bytes];
for (int index = 0; (index < [dataDecode length]) && (index < kEncodeKeyLength); index++, cByte++)
{
    *cByte = (*cByte) ^ arrayForEncode[index];
}

// 根据解密后的Data生成Image
cell.xib_imgView.image = [UIImage imageWithData:dataDecode];
*/