//
//  ViewController.m
//  tools
//
//  Created by navinfo on 2017/9/18.
//  Copyright © 2017年 navinfo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSData *)readFile {

    //文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"kkmklm" ofType:nil];
    NSData *reader=[NSData dataWithContentsOfFile:path];
    
    //读 0~100 字节数据
    NSData *netPCMData = [reader subdataWithRange:NSMakeRange(0, 100)];

    return netPCMData;
}

-(void)writefile:(NSData *)data
{
    NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *homePath = [paths objectAtIndex:0];
    
    NSString *filePath = [homePath stringByAppendingPathComponent:@"export-pcm.caf"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        [data writeToFile:filePath atomically:YES];
    }
    else//追加写入文件，而不是覆盖原来的文件
    {
        //        NSLog(@"-------文件存在，追加文件----------");
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        
        [fileHandle writeData:data]; //追加写入数据
        
        [fileHandle closeFile];
    }
}


@end
