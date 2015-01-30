//
//  ViewResults.m
//  pushCounter
//
//  Created by Chiunti on 28/01/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "ViewResults.h"
#import "CellScore.h"


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
    maScores = [NSMutableArray arrayWithArray:[[DBManager getSharedInstance]allRecords]];
}

- (void)viewDidAppear:(BOOL)animated
{
    int pos;
    
    //for (NSArray *record in maScores)
        //if ([record objectAtIndex:1]=) {
            
        //}
        


NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pos inSection:0];
[self.tableView scrollToRowAtIndexPath:indexPath
                     atScrollPosition:UITableViewScrollPositionMiddle
                             animated:YES];
[self.tableView selectRowAtIndexPath:indexPath
                            animated:YES
                      scrollPosition:UITableViewScrollPositionNone];
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

@end
