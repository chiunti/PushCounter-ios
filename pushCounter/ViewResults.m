//
//  ViewResults.m
//  pushCounter
//
//  Created by Chiunti on 28/01/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "ViewResults.h"
#import "CellScore.h"
#import "DBManager.h"

int pos;

NSMutableArray *maScores;

@interface ViewResults()

@end

@implementation ViewResults

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController
{
    int counter = 0;
    pos = 0;

    maScores = [NSMutableArray arrayWithArray:[[DBManager getSharedInstance]allRecords]];
    for(NSArray *item in maScores) {
        if([[item objectAtIndex:1] integerValue] ==[[DBManager getSharedInstance]lastScore]){
            pos = counter;
        }
        counter++;
    }
}

- (void)viewDidAppear:(BOOL)animated
{


NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pos inSection:0];
[self.tableView scrollToRowAtIndexPath:indexPath
                     atScrollPosition:UITableViewScrollPositionMiddle
                             animated:animated];

 /*[self.tableView selectRowAtIndexPath:indexPath
                            animated:YES
                      scrollPosition:UITableViewScrollPositionNone];
 */
}

/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maScores.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"CellScore");
    static NSString *CellIdentifier = @"CellScore";
    
    CellScore *cell = (CellScore *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CellScore alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableArray *record = maScores[indexPath.row];
    
    cell.lblTitle.text       = [record objectAtIndex:0];
    cell.lblDetail.text      = [record objectAtIndex:1];

    if (indexPath.row == pos) {
        cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.75 blue:0.65 alpha:1];
        //NSLog(@"pos:%d  row:%ld",pos,(long)indexPath.row);
    } else {
        cell.backgroundColor =  [UIColor clearColor];
    }
                                        
    return cell;
}

/*/-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lblSelectedName.text = maScores[indexPath.row];
    NSString *strTemp;
    
    strTemp = [self.lblSelectedName.text stringByAppendingString: @" fué seleccionado"];
    
    if (indexPath.row == 2)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alerta Oaxaca"
                                           message:strTemp
                                          delegate:self
                                 cancelButtonTitle:@"Cancelar"
                                 otherButtonTitles:@"Guardar", @"Publicar", nil];
        [alert show];
    }
}
*/

- (IBAction)btnBackPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
