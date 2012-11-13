//
//  NoteView.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/18/12.
//
//

#import "NoteView.h"
#import "ContentTableViewCell.h"
#import "ContentFullScreen.h"

@implementation NoteView
Note *_note;

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    l.backgroundColor = [UIColor darkGrayColor];
    l.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    l.textColor = [UIColor lightGrayColor];
    l.textAlignment = NSTextAlignmentCenter;
    Section *s = [self.note.notebook.listOfSections objectAtIndex:section];
    l.text = s.name;
    
    return l;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.note.notebook.listOfSections count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Section *s = [self.note.notebook.listOfSections objectAtIndex:section];
    return s.name;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	Section *s = [self.note.notebook.listOfSections objectAtIndex:section];
    if(s ==[self.note.notebook.listOfSections lastObject])
        return [s.listOfControls count] + 1;
    else
        return [s.listOfControls count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Section *s = [self.note.notebook.listOfSections objectAtIndex:indexPath.section];
    if(indexPath.row >= s.listOfControls.count)
        return 200;
    else{
        Control *control = [s.listOfControls objectAtIndex:indexPath.row];
        
        if([control.type isEqualToString:@"MultiText"])
            return 144;
        if([control.type isEqualToString:@"100PointScale"])
            return 70;
        if([control.type isEqualToString:@"Picture"])
            return 144;
        if([control.type isEqualToString:@"Date"])
            return 88;
        
        return 65;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Section *s = [self.note.notebook.listOfSections objectAtIndex:indexPath.section];
    if(indexPath.row >= s.listOfControls.count){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Spacer"];
        return cell;
    }
    else{
        Control *control = [s.listOfControls objectAtIndex:indexPath.row];
        Content *content = [self.note contentInThisControl:control];
        if(!content){
            [self.note addContentToThisControl:control];
            content = [self.note contentInThisControl:control];
        }
        
        ContentTableViewCell *customCell = (ContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:control.type];
        
        if(customCell){
            [customCell setContent:content];
            [customCell setNeedsDisplay];
            return customCell;
        }
    }
    return nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	[label setFont:[UIFont boldSystemFontOfSize:16.0]];
    label.textAlignment = NSTextAlignmentCenter;
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor whiteColor]];
	[label setText:@"Note"];
    
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	[backLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
    backLabel.textAlignment = NSTextAlignmentCenter;
	[backLabel setBackgroundColor:[UIColor clearColor]];
	[backLabel setTextColor:[UIColor whiteColor]];
	[backLabel setText:@"Back"];
    
	[self.navigationController.navigationBar.topItem setTitleView:label];
}

-(void)setNote:(Note *)note{
    _note = note;
    self.title = self.note.titleText;
}

- (void)viewDidUnload {
    [self setTv:nil];
    [super viewDidUnload];
}

- (IBAction)socialButtonAction:(id)sender {
    UIActivityViewController *avc;
    if(self.note.thumbnail)
        avc = [[UIActivityViewController alloc] initWithActivityItems:@[self.note.thumbnail, self.note.socialString] applicationActivities:nil];
    else
        avc = [[UIActivityViewController alloc] initWithActivityItems:@[self.note.socialString] applicationActivities:nil];
    avc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:avc animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"ToImageEditor"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        Section *s = [self.note.notebook.listOfSections objectAtIndex:indexPath.section];
        Control *control = [s.listOfControls objectAtIndex:indexPath.row];
        Content *content = [self.note contentInThisControl:control];
        
        ContentFullScreen *dvc = (ContentFullScreen *)[segue destinationViewController];
        [dvc setContent:content];
        [dvc addUpdateBlock:^{
            ContentTableViewCell *customCell =(ContentTableViewCell *) [self.tv cellForRowAtIndexPath:indexPath];
            [customCell setNeedsDisplay];
        }];
    }
    if ([[segue identifier] isEqualToString:@"ToListEditor"]) {
        NSIndexPath *indexPath = [self.tv indexPathForSelectedRow];
        [self.tv deselectRowAtIndexPath:indexPath animated:NO];
        Section *s = [self.note.notebook.listOfSections objectAtIndex:indexPath.section];
        Control *control = [s.listOfControls objectAtIndex:indexPath.row];
        Content *content = [self.note contentInThisControl:control];
        
        ContentFullScreen *dvc = (ContentFullScreen *)[segue destinationViewController];
        [dvc setContent:content];
        [dvc addUpdateBlock:^{
            ContentTableViewCell *customCell =(ContentTableViewCell *) [self.tv cellForRowAtIndexPath:indexPath];
            [customCell setNeedsDisplay];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Section *s = [self.note.notebook.listOfSections objectAtIndex:indexPath.section];
    Control *control = [s.listOfControls objectAtIndex:indexPath.row];
    if([control.type isEqualToString:@"Date"]){
        [tableView scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];
        CGRect frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 215);
        UIDatePicker *typePicker = [[UIDatePicker alloc] initWithFrame:frame];
        typePicker.datePickerMode = UIDatePickerModeDate;
        Content *content = [self.note contentInThisControl:control];
        NSDate *date =[[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[content.numeric doubleValue]];
        [typePicker setDate:date animated:YES];
        UITableViewCell *cell = [self.tv cellForRowAtIndexPath:indexPath];
        [typePicker addTarget:cell
                       action:@selector(updateDateContent:)
             forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:typePicker];
        [UIView beginAnimations:@"slideIn" context:nil];
        [typePicker setCenter:CGPointMake(typePicker.frame.size.width/2, self.view.frame.size.height - typePicker.frame.size.height/2)];
        [UIView commitAnimations];
    }
}

@end
