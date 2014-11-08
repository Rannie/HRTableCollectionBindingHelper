//
//  ViewController.m
//  HRTableCollectionBindingHelperDemo
//
//  Created by Ran on 14/11/6.
//  Copyright (c) 2014年 Rannie. All rights reserved.
//

#import "ViewController.h"
#import "UserViewModel.h"
#import "HRTableViewBindingHelper.h"
#import "UserCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UserViewModel *viewModel;
@property (nonatomic, strong) HRTableViewBindingHelper *bindingHelper;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[UserViewModel alloc] init];
    
    UINib *cellNib = [UINib nibWithNibName:@"UserCell" bundle:nil];
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"select : %@", input);
        return [RACSignal empty];
    }];
    self.bindingHelper = [HRTableViewBindingHelper bindingForTableView:self.tableView
                                                          sourceSignal:RACObserve(self.viewModel, userList)
                                                   didSelectionCommand:command
                                                          templateCell:cellNib];
}

- (IBAction)onFetchButtonPressed:(id)sender {
    [self.viewModel fetchUsers];
}

@end
