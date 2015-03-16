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
UIGestureRecognizerDelegate,
UIAlertViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *enteredData;
@property NSMutableArray *enteredColors;
@property NSString *enteredText;
//@property (weak, nonatomic) IBOutlet UITableViewCell *cell;
@property CGPoint pointTapped;
@property BOOL shouldWeDelete;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.enteredData = [NSMutableArray new];
    UIGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.delegate = self;
    self.shouldWeDelete = false;
    self.enteredColors = [NSMutableArray new];
    //self.enteredColors = [NSMutableArray arrayWithObjects:[UIColor blackColor], [UIColor blackColor],[UIColor blackColor], nil];
    [self.tableView addGestureRecognizer:swipeRight];
    //[self.tableView addGestureRecognizer:swipeRight];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    self.enteredText = self.textField.text;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.enteredData[indexPath.row]];
    cell.textLabel.textColor = [self.enteredColors objectAtIndex:indexPath.row];
//    if (!(cell.textLabel.textColor == [UIColor blackColor])) {
//        cell.textLabel.textColor = [self.enteredColors objectAtIndex:indexPath.row];
//    } else if (cell.textLabel.textColor == [UIColor blackColor]) {
//        return cell;
//    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.enteredData.count;
}

- (IBAction)onAddButtonPressed:(id)sender {
    self.textField.textColor = [UIColor blackColor];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WOAH"
                                                        message:@"Are you sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", nil];

        [alertView show];
        //[self.enteredColors removeObjectAtIndex:indexPath.row];
        [self.enteredData removeObjectAtIndex:indexPath.row];

        self.shouldWeDelete = false;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.enteredData removeObject:indexPath];
        self.shouldWeDelete = true;
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSString *tempString = [self.enteredData objectAtIndex:sourceIndexPath.row];
//    UIColor *tempColor = [self.enteredColors objectAtIndex:sourceIndexPath.row];
    UITableViewCell *tempCell = [tableView cellForRowAtIndexPath:sourceIndexPath];
    [self.enteredData removeObjectAtIndex:sourceIndexPath.row];
    [self.enteredData insertObject:tempCell.textLabel.text atIndex:destinationIndexPath.row];
    [self.enteredColors removeObjectAtIndex:sourceIndexPath.row];
    [self.enteredColors insertObject:tempCell.textLabel.textColor atIndex:destinationIndexPath.row];
//    [self.enteredData removeObject:tempString];
//    [self.enteredData addObject:tempString];
//    [self.enteredColors removeObject:tempColor];
//    [self.enteredColors addObject:tempColor];
    //[self.tableView reloadData];
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

- (void)swipeRight:(UIGestureRecognizer *)gesture {

    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    if (indexPath) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.textLabel.textColor == [UIColor blackColor]) {
            cell.textLabel.textColor = [UIColor greenColor];
            [self.enteredColors setObject:[UIColor greenColor] atIndexedSubscript:indexPath.row];
        } else if (cell.textLabel.textColor == [UIColor greenColor]) {
            cell.textLabel.textColor = [UIColor yellowColor];
            [self.enteredColors setObject:[UIColor yellowColor] atIndexedSubscript:indexPath.row];
        } else if (cell.textLabel.textColor == [UIColor yellowColor]) {
            cell.textLabel.textColor = [UIColor redColor];
            [self.enteredColors setObject:[UIColor redColor] atIndexedSubscript:indexPath.row];
        }
    }
}



@end
