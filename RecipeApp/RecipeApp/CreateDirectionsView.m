//
//  CreateDirectionsView.m
//  RecipeApp
//
//  Created by Rajul Arora on 2014-11-28.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "CreateDirectionsView.h"
#import "DirectionsTableViewCell.h"
#import "DirectionsHeaderView.h"
#import "RATextField.h"

@interface CreateDirectionsView () <UITableViewDelegate, UITableViewDataSource, DirectionsTableViewCellDelegate, DirectionsHeaderViewDelegate>

@property (nonatomic, strong) NSMutableArray *directionSections;
@property (nonatomic, strong) NSMutableArray *directionSectionHeaders;

@end

@implementation CreateDirectionsView

- (instancetype)init
{
    if (self = [super init])
    {
        self.directionsLabel = [[UILabel alloc] init];
        self.directionsLabel.text = @"Directions";
        self.directionsLabel.textColor = [UIColor lightGrayColor];
        self.directionsLabel.font = [UIFont systemFontOfSize:20.0f];
        self.directionsLabel.textAlignment = NSTextAlignmentCenter;
        self.directionsLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        [self addSubview:self.directionsLabel];
        
        self.separatorView = [[UIView alloc] init];
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.separatorView];
        
        self.directionsTableView = [[UITableView alloc] init];
        self.directionsTableView.delegate = self;
        self.directionsTableView.dataSource = self;
        self.directionsTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
        self.directionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.directionsTableView.showsHorizontalScrollIndicator = NO;
        self.directionsTableView.showsVerticalScrollIndicator = NO;
        [self.directionsTableView registerClass:[DirectionsTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.directionsTableView];
        
        self.directionSections = [[NSMutableArray alloc] init];
        self.directionSectionHeaders = [[NSMutableArray alloc] init];
        
        NSMutableArray *directionSet = [[NSMutableArray alloc] init];
        
        // Fake Data for testing (remove when done)
        [directionSet addObject:@"one"];
        [directionSet addObject:@"two"];
        [directionSet addObject:@"three"];
        
        [self.directionSections addObject:directionSet];
        
        [self.directionSectionHeaders addObject:@"Section Title"];
        
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.doneButton setTitle:@"Done!" forState:UIControlStateNormal];
        [self.doneButton setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
        [self.doneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        self.doneButton.backgroundColor = [UIColor colorWithRed:76.0f/255.0f green:217.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        [self.doneButton addTarget:self action:@selector(didFinishEditing:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.doneButton];

    }
    return self;
}

- (void)layoutSubviews
{
    CGSize sizeThatFitsDirectionsLabel = [self.directionsLabel sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    self.directionsLabel.frame = CGRectMake(5.0f, 5.0f, self.frame.size.width, sizeThatFitsDirectionsLabel.height);
    self.separatorView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.directionsLabel.frame) + 5.0f , self.frame.size.width - 20.0f, 1.0f);
    self.directionsTableView.frame = CGRectMake(10.0f, CGRectGetMaxY(self.separatorView.frame) + 10.0f, self.frame.size.width - 20.0f, self.frame.size.height - CGRectGetMaxY(self.separatorView.frame) - 60.0f);
    self.doneButton.frame = CGRectMake(5.0f, CGRectGetMaxY(self.directionsTableView.frame) + 5.0f, self.frame.size.width - 10.0f, 40.0f);
    self.doneButton.layer.cornerRadius = 2.0f;
}

#pragma mark - Actions

- (void)didFinishEditing:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didFinishWritingRecipe)])
    {
        [self.delegate didFinishWritingRecipe];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DirectionsTableViewCell *cell = (DirectionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[DirectionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    if (indexPath.section < self.directionSections.count)
    {
        NSMutableArray *directions = self.directionSections[indexPath.section];
        if (indexPath.row < directions.count && !cell.directionTextView)
        {
            [cell setupDirectionTextView];
        }
        else if (indexPath.row == directions.count && !cell.addDirectionButton)
        {
            [cell setupAddDirectionButton];
        }
        else if (indexPath.row == directions.count + 1 && !cell.addSectionButton)
        {
            [cell setupAddSectionButton];
        }
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *directions = self.directionSections[section];
    return directions.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.directionSections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.directionSections.count)
    {
        NSMutableArray *directions = self.directionSections[indexPath.section];
        
        if (indexPath.row < directions.count)
        {
            NSString *text = directions[indexPath.row];
            DirectionsTableViewCell *cell = [[DirectionsTableViewCell alloc] init];
            [cell setupDirectionTextView];
            cell.directionTextView.text = text;
            CGSize sizeThatFits = [cell.directionTextView sizeThatFits:CGSizeMake(tableView.frame.size.width, CGFLOAT_MAX)];
            return sizeThatFits.height;
        }
    }
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Section Header Data
    NSString *sectionTitle = self.directionSectionHeaders[section];
    DirectionsHeaderView *directionsHeader = [[DirectionsHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40.0f) sectionNumber:section];
    directionsHeader.delegate = self;
    directionsHeader.textField.text = sectionTitle;
    directionsHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    return directionsHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

#pragma mark - DirectionsTableViewCellDelegate

- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didTapAddDirectionButtonAtIndexPath:(NSIndexPath *)indexPath
{
    //Add new Row
    NSMutableArray *directions = self.directionSections[indexPath.section];
    [directions addObject:@"New Step"];
    [self.directionsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:directions.count - 1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.directionsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:directions.count + 1 inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didTapAddSectionButtonAtIndexPath:(NSIndexPath *)indexPath
{
    //Add new Section
    NSMutableArray *newDirectionsArray = [[NSMutableArray alloc] init];
    [self.directionSections insertObject:newDirectionsArray atIndex:indexPath.section+1];
    [self.directionSectionHeaders insertObject:@"New Section" atIndex:indexPath.section +1];
    [self.directionsTableView insertSections:[NSIndexSet indexSetWithIndex:indexPath.section+1] withRowAnimation:UITableViewRowAnimationBottom];
        [self.directionsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newDirectionsArray.count+1 inSection:indexPath.section + 1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didFinishEditingAtIndexPath:(NSIndexPath *)indexPath
{
    //Update Data source with textfield content
    if (indexPath.section < self.directionSections.count)
    {
        NSMutableArray *directions = self.directionSections[indexPath.section];
        if (indexPath.row < directions.count)
        {
            if (cell.directionTextView.text)
            {
                [self.directionsTableView beginUpdates];
                directions[indexPath.row] = cell.directionTextView.text;
                [self.directionsTableView endUpdates];
            }
        }
    }
}

- (void)directionsTableViewCell:(DirectionsTableViewCell *)cell didChangeTextViewAtIndexPath:(NSIndexPath *)indexPath
{
    //Update Data source with textfield content
    if (indexPath.section < self.directionSections.count)
    {
        NSMutableArray *directions = self.directionSections[indexPath.section];
        if (indexPath.row < directions.count)
        {
            if (cell.directionTextView.text)
            {
                [self.directionsTableView beginUpdates];
                directions[indexPath.row] = cell.directionTextView.text;
                [self.directionsTableView endUpdates];
            }
        }
    }
}

#pragma mark - DirectionsHeaderViewDelegate

- (void)directionsHeaderView:(DirectionsHeaderView *)headerView didUpdateHeaderViewInSection:(NSUInteger)sectionNumber
{
    // Update array for headers
    self.directionSectionHeaders[sectionNumber] = headerView.textField.text;
}

- (void)directionsHeaderView:(DirectionsHeaderView *)headerView didTapDeleteHeaderViewInSection:(NSUInteger)sectionNumber
{
    if (self.directionSectionHeaders.count > 1)
    {
        [self.directionSectionHeaders removeObjectAtIndex:sectionNumber];
        [self.directionSections removeObjectAtIndex:sectionNumber];
        [self.directionsTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionNumber] withRowAnimation:UITableViewRowAnimationBottom];
        [self.directionsTableView reloadData];
    }
}

@end
