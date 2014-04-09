//
//  Notebooks.m
//  TastingNotes
//
//  Created by Matthew Campbell on 2/3/11.
//  Copyright 2011 App Shop LLC. All rights reserved.
//

#import "Notebooks.h"

@implementation Notebooks

-(NSMutableArray *)listOfNotebooks {
	if(listOfNotebooks == nil){
		NSArray *pklist = [[SQLiteDB sharedDatabase] getColumnValuesFromThisTable:@"ListsTable"
														 usingThisSelectStatement:@"SELECT pk FROM ListsTable ORDER BY ListOrder;"
																   fromThisColumn:0];	
		listOfNotebooks = [[NSMutableArray alloc] init];
		Notebook *nb;
        int i  =0;
		for(NSNumber *pk in pklist){
			nb = [[Notebook alloc] initWithPrimaryKey:pk];
            if(!nb.order)
                nb.order = [NSNumber numberWithInt:i];
            i++;
			[listOfNotebooks addObject:nb];
		} 
		
		return listOfNotebooks;
	}
	else
		return listOfNotebooks;
}

-(void)addNewNotebookWithThisName:(NSString *)newTableName{
	[self listOfNotebooks];
	NSNumber *pk = [[SQLiteDB sharedDatabase] addRowToThisTable:@"ListsTable"
											 withThisColumnName:@"ListName"
												  withThisValue:newTableName];			 
	
	Notebook *notebook = [[Notebook alloc] initWithPrimaryKey:pk];
	
	NSNumber *listOrder = [[SQLiteDB sharedDatabase] getValueFromThisTable:@"ListsTable"
												  usingThisSelectStatement:@"SELECT Max(ListOrder) + 1 AS N FROM ListsTable"];
	
	if((NSNull *)listOrder == [NSNull null])
		listOrder = [NSNumber numberWithInt:0];
	notebook.order = listOrder;
	
	[self.listOfNotebooks addObject:notebook];
}

-(void)addListItemWithThisListControlPK:(NSNumber *)listControlPK andThisValue:(NSString *)listItemValue{
	SQLiteDB *database = [SQLiteDB sharedDatabase];
	NSNumber *listItem_pk = [database addRowToThisTable:@"TagValues" 
									 withThisColumnName:@"fk_ToControlTable" 
										  withThisValue:[NSString stringWithFormat:@"%@", listControlPK]];
	[database executeThisSQLStatement:[NSString stringWithFormat:@"UPDATE TagValues SET TagValueOrder = 0, TagValueNum = 0, TagValueText = '%@' WHERE pk = %@;", 
									   NSLocalizedString(listItemValue,listItemValue), listItem_pk]];
}

-(void)populateThisListControl:(ListControl *)listControl{
	//Wines
	if([listControl.title isEqualToString:NSLocalizedString(@"WineType", @"WineType")])
		for(int i = 1;i<8;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WT%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"Varietals", @"Varietals")])
		for(int i = 1;i<14;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WV%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"Winery", @"Winery")])
		for(int i = 1;i<3;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WW%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"Region", @"Region")])
		for(int i = 1;i<22;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WR%i",i]];	
	if([listControl.title isEqualToString:NSLocalizedString(@"Pairing", @"Pairing")])
		for(int i = 1;i<6;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WP%i",i]];	
	//Beer List
	if([listControl.title isEqualToString:NSLocalizedString(@"Brewery", @"Brewery")])
		for(int i = 1;i<17;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"BB%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"BeerCountry", @"BeerCountry")])
		for(int i = 1;i<13;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"BR%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"BeerStyle", @"BeerStyle")])
		for(int i = 1;i<107;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"BS%i",i]];
	//Whiskey List
	if([listControl.title isEqualToString:NSLocalizedString(@"WhiskeyType", @"WhiskeyType")])
		for(int i = 1;i<6;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WhT%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"Area", @"Area")])
		for(int i = 1;i<6;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WhA%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"Distillery", @"Distillery")])
		for(int i = 1;i<33;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"WhD%i",i]];
	//Tea List
	if([listControl.title isEqualToString:NSLocalizedString(@"TeaType", @"TeaType")])
		for(int i = 1;i<9;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"TT%i",i]];
	//Coffee List
	if([listControl.title isEqualToString:NSLocalizedString(@"CoffeeVariety", @"CoffeeVariety")])
		for(int i = 1;i<21;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"CfV%i",i]];
	if([listControl.title isEqualToString:NSLocalizedString(@"CoffeeDrinkType", @"CoffeeDrinkType")])
		for(int i = 1;i<27;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"CfD%i",i]];
	//Cigars
	if([listControl.title isEqualToString:NSLocalizedString(@"CigarType", @"CigarType")])
		for(int i = 1;i<10;i++)
			[self addListItemWithThisListControlPK:listControl.pk 
									  andThisValue:[NSString stringWithFormat:@"CgT%i",i]];	
}

-(void)addControlWithThisTitle:(NSString *)title andThisType:(NSString *)type{
	SQLiteDB *database = [SQLiteDB sharedDatabase];
	Notebook *notebook = [listOfNotebooks lastObject];
	Section *section = [notebook.listOfSections lastObject];
	[notebook addControlToThisNotebook];
	Control *control = [section.listOfControls lastObject];
	[database executeThisSQLStatement:[NSString stringWithFormat: @"UPDATE ControlTable SET ControlType = '%@', ControlPushesToScreen = 'NO', AllowsMultipleSelections = 'NO', CanEdit = 'YES' WHERE pk = %@;", type, control.pk]];
	control.title = title;
	if([control.type isEqualToString:@"List"]){
		ListControl *lc = [[ListControl alloc] initWithPrimaryKey:control.pk inThisSection:section];
		[section.listOfControls removeLastObject];
		[section.listOfControls addObject:lc];
	}
}

-(void)addNewNotebookWithThisType:(NotebookType)notebooktype{
	Notebook *notebook;
	Section *section;
	Control *control;
	switch (notebooktype) {
		case Wine:{
			[self addNewNotebookWithThisName:@"Wines"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Note";
			
			[self addControlWithThisTitle:NSLocalizedString(@"WineName", @"WineName") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"WineType", @"WineType") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"WineBottleLabel", @"WineBottleLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			[self addControlWithThisTitle:@"Rating" andThisType:@"5StarRating"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"DetailedDescriptors", @"DetailedDescriptors");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Vintage", @"Vintage") andThisType:@"Numeric"];
			[self addControlWithThisTitle:NSLocalizedString(@"Price", @"Price") andThisType:@"Currency"];
			[self addControlWithThisTitle:NSLocalizedString(@"Varietals", @"Varietals") andThisType:@"List"];
			[self addControlWithThisTitle:NSLocalizedString(@"Region", @"Region") andThisType:@"List"];
			
		}
			break;
		case Beer:{
			[self addNewNotebookWithThisName:@"Beers"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Beer Overview";
			
			[self addControlWithThisTitle:NSLocalizedString(@"BeerName", @"BeerName") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"BeerStyle", @"BeerStyle") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Price", @"Price") andThisType:@"Currency"];
			[self addControlWithThisTitle:NSLocalizedString(@"BeerBottleLabel", @"BeerBottleLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"DetailedDescriptors", @"DetailedDescriptors");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Brewery", @"Brewery") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"BeerCountry", @"BeerCountry") andThisType:@"List"];
			[self addControlWithThisTitle:NSLocalizedString(@"Pairing", @"Pairing") andThisType:@"List"];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Charactoristics", @"Charactoristics");
			
			[self addControlWithThisTitle:NSLocalizedString(@"DateTasted", @"DateTasted") andThisType:@"Date"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Color", @"Color") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Carbonation", @"Carbonation") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Aroma", @"Aroma") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Taste", @"Taste") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
		}
			break;
		case Whiskey:{
			[self addNewNotebookWithThisName:@"Whiskey"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Whiskey Overview";
			
			[self addControlWithThisTitle:NSLocalizedString(@"WhiskeyName", @"WhiskeyName") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"WhiskeyType", @"WhiskeyType") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"WhiskeyAgeInYears", @"WhiskeyAgeInYears") andThisType:@"Numeric"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Proof", @"Proof") andThisType:@"Numeric"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Price", @"Price") andThisType:@"Currency"];
			[self addControlWithThisTitle:NSLocalizedString(@"WhiskeyBottleLabel", @"WhiskeyBottleLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Ratings", @"Ratings");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Rating100", @"Rating100") andThisType:@"100PointScale"];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"DetailedDescriptors", @"DetailedDescriptors");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Distillery", @"Distillery") andThisType:@"List"];
			[self addControlWithThisTitle:NSLocalizedString(@"Area", @"Area") andThisType:@"List"];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Charactoristics", @"Charactoristics");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Color", @"Color") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Nose", @"Nose") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Body", @"Body") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Palate", @"Palate") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Finish", @"Finish") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
		}
			break;
		case Cigars:{
			[self addNewNotebookWithThisName:@"Cigars"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Cigar Overview";
			
			[self addControlWithThisTitle:NSLocalizedString(@"Name", @"Name") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"CigarType", @"CigarType") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"RingGauge", @"RingGauge") andThisType:@"Numeric"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"Length", @"Length") andThisType:@"Numeric"];
			[self addControlWithThisTitle:NSLocalizedString(@"Price", @"Price") andThisType:@"Currency"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"ImageLabel", @"ImageLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Ratings", @"Ratings");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Rating100", @"Rating100") andThisType:@"100PointScale"];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Charactoristics", @"Charactoristics");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Look", @"Look") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"LightAndBurn", @"LightAndBurn") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Draw", @"Draw") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Smoke", @"Smoke") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Flavor", @"Flavor") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
		}
			break;
		case Coffee:{
			[self addNewNotebookWithThisName:@"Coffee"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Coffee Overview";
			
			[self addControlWithThisTitle:NSLocalizedString(@"Name", @"Name") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"CoffeeVariety", @"CoffeeVariety") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"CoffeeDrinkType", @"CoffeeDrinkType") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"ImageLabel", @"ImageLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Ratings", @"Ratings");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Rating100", @"Rating100") andThisType:@"100PointScale"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Charactoristics", @"Charactoristics");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Color", @"Color") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Aroma", @"Aroma") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Taste", @"Taste") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Mouthfeel", @"Mouthfeel") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
		}
			break;
		case Tea:{
			[self addNewNotebookWithThisName:@"Tea Notebook"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Tea Overview";
			
			[self addControlWithThisTitle:NSLocalizedString(@"Name", @"Name") andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"TeaType", @"TeaType") andThisType:@"List"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
			[self addControlWithThisTitle:NSLocalizedString(@"ImageLabel", @"ImageLabel") andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Ratings", @"Ratings");
			
			[self addControlWithThisTitle:NSLocalizedString(@"Rating100", @"Rating100") andThisType:@"100PointScale"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = NSLocalizedString(@"Charactoristics", @"Charactoristics");
			
			[self addControlWithThisTitle:NSLocalizedString(@"DryLeafAppearance", @"DryLeafAppearance") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"WetLeafAppearance", @"WetLeafAppearance") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Liquor", @"Liquor") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Aroma", @"Aroma") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Taste", @"Taste") andThisType:@"MultiText"];
			[self addControlWithThisTitle:NSLocalizedString(@"Comments", @"Comments") andThisType:@"MultiText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge4Control_fk = control.pk;
		}
			break;
        case GeneralNote:{
			[self addNewNotebookWithThisName:@"Notes"];
			notebook = [listOfNotebooks lastObject];
			
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Overview";
			[self addControlWithThisTitle:@"Name" andThisType:@"SmallText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge1Control_fk = control.pk;
			[self addControlWithThisTitle:@"Note Date" andThisType:@"Date"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge2Control_fk = control.pk;
            [self addControlWithThisTitle:@"Picture" andThisType:@"Picture"];
			control = [section.listOfControls lastObject];
			notebook.noteImageBadgeControl_fk = control.pk;
            
			[notebook addSectionToThisNotebook];
			section = [notebook.listOfSections lastObject];
			section.name = @"Detailed Comments";
			[self addControlWithThisTitle:@"Comments" andThisType:@"MultiText"];
			control = [section.listOfControls lastObject];
			notebook.noteBadge3Control_fk = control.pk;
		}
			break;
		default:{
			[self addNewNotebookWithThisName:@"Notebook"];
		}
			break;
	}
}

-(void)removeThisNotebook:(Notebook *)notebookToRemove{
    [[SQLiteDB sharedDatabase] executeThisSQLStatement:[NSString stringWithFormat:@"DELETE FROM ListsTable WHERE pk = %@", notebookToRemove.pk]];
    [self.listOfNotebooks removeObject:notebookToRemove];
}

-(void)moveNotebookAtThisIndex:(int)fromIndex toThisIndex:(int)toIndex{
    Notebook *fromNB = [self.listOfNotebooks objectAtIndex:fromIndex];
    Notebook *toNB = [self.listOfNotebooks objectAtIndex:toIndex];
    
    NSNumber *fromOrder;
    NSNumber *toOrder;
    
    fromOrder = [[NSNumber alloc] initWithInt:fromIndex];
    toOrder = [[NSNumber alloc] initWithInt:toIndex];
    
    fromNB.order = toOrder;
    toNB.order = fromOrder;
    
    [self.listOfNotebooks exchangeObjectAtIndex:fromIndex
                              withObjectAtIndex:toIndex];
}

-(void)resetData{
    listOfNotebooks = nil;
}

@end