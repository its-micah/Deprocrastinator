//
//  ViewController.m
//  Deprocrastinatoooor
//
//  Created by Micah Lanier on 3/16/15.
//  Copyright (c) 2015 Micah Lanier Design and Illustration. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

<
UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *enteredData;
@property NSString *enteredText;
//@property (weak, nonatomic) IBOutlet UITableViewCell *cell;
@property CGPoint pointTapped;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enteredData = [NSMutableArray new];
    [self swipeRight];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    self.enteredText = self.textField.text;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.enteredData[indexPath.row]];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.enteredData.count;
}
- (IBAction)onAddButtonPressed:(id)sender {
    self.enteredText = [NSString stringWithFormat:@"%@", self.textField.text];
    [self.enteredData addObject:self.textField.text];
    [self.tableView reloadData];
    self.textField.text = @"";
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.enteredData removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.editing) {
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    } else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        [self.view endEditing:YES];

    }
}

- (BOOL)swipeRight {

    UIGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self.tableView.subviews action:@selector(selector)];
    [self.tableView addGestureRecognizer:swipeRight];
    return YES;
}



@end
