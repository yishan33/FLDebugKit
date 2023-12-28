//
//  FLDEBUGViewController.m
//  FLDebugKit
//
//  Created by 021159 on 12/07/2023.
//  Copyright (c) 2023 021159. All rights reserved.
//

#import "FLDEBUGViewController.h"

@interface FLDEBUGViewController ()

@end

@implementation FLDEBUGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configDisplaySections:[[FLDebugManager standardManager] allSections] cellItems:[[FLDebugManager standardManager] allCellItems]];
    [self.tableView reloadData];
}


@end
