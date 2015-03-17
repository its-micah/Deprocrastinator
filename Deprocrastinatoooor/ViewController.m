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
UITextFieldDelegate,
UIAlertViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *enteredData;
@property NSMutableArray *enteredColors;
@property NSString *enteredText;
@property UITableViewCell *selectedCell;
@property CGPoint pointTapped;
@property CGPoint pointOfSwipe;
@property BOOL shouldWeDelete;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.enteredData = [NSMutableArray arrayWithObjects: nil];
//    self.enteredColors = [NSMutableArray arrayWithObjects: nil];
    self.enteredData = [NSMutableArray new];
    self.enteredColors = [NSMutableArray new];

    UIGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeRight.delegate = self;
    self.tableView.delegate = self;
    self.shouldWeDelete = false;
    self.enteredColors = [NSMutableArray arrayWithObjects:[UIColor blackColor], [UIColor blackColor],[UIColor blackColor], nil];
    [self.tableView addGestureRecognizer:swipeRight];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
        NSString *titleItem = [self.enteredData objectAtIndex:sourceIndexPath.row];
        UIColor *tempColor = [self.enteredColors objectAtIndex:sourceIndexPath.row];
    [self.enteredData removeObject:titleItem];
    [self.enteredData insertObject:titleItem atIndex:destinationIndexPath.row];
    [self.enteredColors removeObject:tempColor];
    [self.enteredColors insertObject:tempColor atIndex:destinationIndexPath.row];

}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WOAH"
                                                            message:@"Are you sure?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Delete", nil];
        [alertView show];

    }

    self.shouldWeDelete = false;
    [self.tableView reloadData];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    self.enteredText = self.textField.text;
    cell.textLabel.text = [self.enteredData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [self.enteredColors objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.enteredData.count;
}

- (IBAction)onAddButtonPressed:(id)sender {
    NSString *enteredText = self.textField.text;
    [self.enteredData addObject:enteredText];
    [self.enteredColors addObject:[UIColor blackColor]];
    self.textField.text = @"";
    [self.view endEditing:YES];
    [self.tableView reloadData];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor greenColor];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}





-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setEditing:YES animated:YES];
    return YES;
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //self.shouldWeDelete = true;
        [self.enteredData removeObjectAtIndex:indexPath.row];
        [self.enteredColors removeObjectAtIndex:indexPath.row];

        [self.tableView reloadData];
    }
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
