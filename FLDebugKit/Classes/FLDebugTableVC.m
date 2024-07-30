//
//  FLDebugTableVC.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugTableVC.h"
#import "FLDebugManager.h"
#import "FLDebugCellItemText.h"
#import "FLDebugTableBaseCell.h"
#import "FLDebugUtils.h"

@interface FLDebugTableVC ()

@property (nonatomic, strong) NSArray <NSString *> *sections;

@property (nonatomic, strong) NSArray < NSArray<FLDebugCellItem *> *> *cellItems;

@property (nonatomic, strong) FLDebugManager *manager;

@end

@implementation FLDebugTableVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configDefaultSetting];
    }
    return self;
}

- (instancetype)initWithManager:(FLDebugManager *)manager
{
    if (self = [self init]) {
        self.manager = manager;
        [self configDefaultSetting];
    }
    return self;
}

- (void)loadView {
    if (@available(iOS 13.0, *)) {
        self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    } else {
        self.view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[FLDebugCellItem bindCellClass] forCellReuseIdentifier:[FLDebugCellItem bindCellReuseIdentifier]];
    [self.tableView registerClass:[FLDebugCellItemText bindCellClass] forCellReuseIdentifier:[FLDebugCellItemText bindCellReuseIdentifier]];
    [self.tableView registerClass:[FLDebugCellItemSwitch bindCellClass] forCellReuseIdentifier:[FLDebugCellItemSwitch bindCellReuseIdentifier]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)configDisplaySections:(NSArray *)sections cellItems:(NSArray *)cellItems
{
    self.sections = sections;
    self.cellItems = cellItems;
    if (self.isViewLoaded) {
        [self.tableView reloadData];
    }
}

- (void)configDefaultSetting
{
    [self.manager registerRecentItems];
    [self configDisplaySections:[self.manager allSections] cellItems:[self.manager allCellItems]];
}

#pragma mark - FLDebugTabVCProtocol
- (FLDebugManager *)manager
{
    if (!_manager) {
        _manager = [FLDebugManager standardManager];
    }
    return _manager;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellItems[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLDebugCellItem *cellItem = self.cellItems[indexPath.section][indexPath.row];
    NSString *reuseIdentifier = [[cellItem class] bindCellReuseIdentifier];
    
    FLDebugTableBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[FLDebugTableBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell renderCellWithItem:cellItem];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLDebugCellItem *cellItem = self.cellItems[indexPath.section][indexPath.row];
    return [[cellItem class] cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 24;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tap row :%@", @(indexPath.row));
    FLDebugCellItem *cellItem = self.cellItems[indexPath.section][indexPath.row];
    [cellItem doAction];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *sectionStr = self.sections[section];
    if (@available(iOS 13, *)) {
        if (tableView.style == UITableViewStyleInsetGrouped) {
            return sectionStr;
        }
    }

    return nil; // For plain/gropued style
}

@end
