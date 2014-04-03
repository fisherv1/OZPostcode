//
//  ViewController.m
//  OZPostcode
//
//  Created by Matthew Lu on 31/03/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import "ViewController.h"
#import "postcodeFactory.h"
#import "MapViewController.h"
@interface ViewController ()
{
    NSArray *postCodeArray;
    Postcode *selectedPostcode;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController
@synthesize tableview,searchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableview.delegate = self;
    tableview.dataSource = self;
    searchBar.delegate = self;
    postCodeArray = [NSMutableArray new];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}
- (void) hideKeyboard
{
    [searchBar resignFirstResponder];
}





-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSString *inputString = self.searchBar.text;
//    
//    postCodeArray = [postcodeFactory getPostcodeByPostcode:inputString and:kOZ];
//    
//    [tableview reloadData];
    [self hideKeyboard];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Cancel");
}




-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *inputString = self.searchBar.text;
    
    postCodeArray = [postcodeFactory getPostcodeByPostcode:inputString and:kOZ];
    
    [tableview reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell ;
    static NSString *CellIdentifier = @"Cell";

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
         Postcode *postcode = [postCodeArray objectAtIndex:indexPath.row];
         UILabel *postcodelbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 280, 30)];
    
         UILabel *suburblbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 35, 280, 30)];
    
        // Australia postcode
        if ([postcode.country isEqualToString:kAU]) {

            postcodelbl.text = [NSString stringWithFormat:@"%@ - %@ - %@",postcode.postcode, postcode.state, postcode.country];
           
        }
        else // New Zealand postcode
        {
          postcodelbl.text = [NSString stringWithFormat:@"%@ - %@",postcode.postcode, postcode.country];
        }
    
        suburblbl.text = [NSString stringWithFormat:@"Suburb: %@",postcode.suburb];
        suburblbl.adjustsFontSizeToFitWidth = YES;
    
    
        [cell addSubview:postcodelbl];
        [cell addSubview:suburblbl];
    
    
    return cell;
}



#pragma headerview show
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
           return  70 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return postCodeArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedPostcode = [postCodeArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ToMap" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToMap"]) {
        MapViewController *mapViewController  = [segue destinationViewController];
        mapViewController.postcode = selectedPostcode;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
