//
//  Created by Mo Moosa on 01/12/2012.
//  Copyright (c) 2012 MoFo. All rights reserved.
//  CNDataController currently loads static data
//  but will ultimately load and parse JSON data
//  which will then be stored in Core Data.

#import "CNDataController.h"
#import "CNBuilding.h"
#import "CNAnnotation.h"
@interface CNDataController ()
@end

@implementation CNDataController


-(void)initializeDefaultDataList
{
    NSMutableArray *sightingList = [[NSMutableArray alloc]init];


    self.masterBirdSightingList=sightingList;

    
    CLLocationCoordinate2D faradayCoords[5]={
		
        CLLocationCoordinate2DMake(51.49718957003158,-0.1008453416799415),
        CLLocationCoordinate2DMake(51.49709727402367,-0.100464312684676),
        CLLocationCoordinate2DMake(51.4976161448699,-0.1003491672707524),
        CLLocationCoordinate2DMake(51.49765494273916,-0.1007516799051655),
        CLLocationCoordinate2DMake(51.49718957003158,-0.1008453416799415),
        
        
        
	};
    
    MKPolygon *faradayPolygon=[MKPolygon polygonWithCoordinates:faradayCoords count:5];
    faradayPolygon.title = @"Business";
    CLLocationCoordinate2D mclarenCoords[6]={
		
        CLLocationCoordinate2DMake(51.4988354072503,-0.1056801561689547),
        CLLocationCoordinate2DMake(51.49877904601156,-0.1052514142678529),
        CLLocationCoordinate2DMake(51.49902588308377,-0.1049346720958921),
        CLLocationCoordinate2DMake(51.49967777246824,-0.104908238441267),
        CLLocationCoordinate2DMake(51.49914418757093,-0.1060312554266918),
        CLLocationCoordinate2DMake(51.4988354072503,-0.1056801561689547),
        
	};
    
    MKPolygon *mclarenPolygon=[MKPolygon polygonWithCoordinates:mclarenCoords count:6];
    mclarenPolygon.title = @"Residence";
    
    
    //London Road Building Coordinates
    CLLocationCoordinate2D londonRoadCoords[6]={
		
        CLLocationCoordinate2DMake(51.49708111714975,-0.1025044747916493),
        CLLocationCoordinate2DMake(51.4975154570288,-0.1016568071512292),
        CLLocationCoordinate2DMake(51.49794377087164,-0.1022239383849044),
        CLLocationCoordinate2DMake(51.49784816312192,-0.1029470909868346),
        CLLocationCoordinate2DMake(51.49766694458097,-0.1033045309336555),
        CLLocationCoordinate2DMake(51.49708111714975,-0.1025044747916493),
        
	};
    
    
    
    MKPolygon *londonRoadPolygon=[MKPolygon polygonWithCoordinates:londonRoadCoords count:6];
    londonRoadPolygon.title = @"DELETE";
    
    //Keyworth Coordinates
    CLLocationCoordinate2D keyworthCoords[6]={
		
        CLLocationCoordinate2DMake(51.49770635793582,-0.1016046315591324),
        CLLocationCoordinate2DMake(51.49725922454645,-0.1010174129233654),
        CLLocationCoordinate2DMake(51.49768900697587,-0.1008954299594755),
        CLLocationCoordinate2DMake(51.4977306377735,-0.1011308956339341),
        CLLocationCoordinate2DMake(51.49784952380145,-0.1013348654589941),
        CLLocationCoordinate2DMake(51.49770635793582,-0.1016046315591324),
        
	};
    
    MKPolygon *keyworthPolygon=[MKPolygon polygonWithCoordinates:keyworthCoords count:6];
    keyworthPolygon.title = @"Health and Social Care";
    NSLog(@"londonRoadCoordinates %f",keyworthPolygon.coordinate.latitude);
    NSLog(@"londonRoadCoordinates %f",keyworthPolygon.coordinate.longitude);


    //Keyworth Coordinates
    CLLocationCoordinate2D k2Coords[7]={
	
        
        CLLocationCoordinate2DMake(51.49770546645995,-0.1016205002065484),
        CLLocationCoordinate2DMake(51.49786860338006,-0.1012758391357749),
        CLLocationCoordinate2DMake(51.49809194118692,-0.1015800449167803 ),
        CLLocationCoordinate2DMake(51.49803387377534,-0.1017073118851541),
        CLLocationCoordinate2DMake(51.4983519739095,-0.1021170729423193),
        CLLocationCoordinate2DMake(51.49825537354742,-0.102314439549327),
        CLLocationCoordinate2DMake(51.49770546645995,-0.1016205002065484),

        
	};
    
    MKPolygon *k2Polygon=[MKPolygon polygonWithCoordinates:k2Coords count:7];

    CLLocationCoordinate2D danteCoords[10]={
        
        
//        CLLocationCoordinate2DMake(51.49157623099137,0.103102382107817),
        CLLocationCoordinate2DMake(51.49221620851509,-0.1021735062020845),
        CLLocationCoordinate2DMake(51.49238138319386,-0.1024219263993875),
        CLLocationCoordinate2DMake(51.4922178411603,-0.1027167024762454),
        CLLocationCoordinate2DMake(51.49312056763942, -0.1037797231232629),
        CLLocationCoordinate2DMake(51.49305492774216, -0.1039224652838844),
        CLLocationCoordinate2DMake(51.49215616292162,-0.1029210342606979),
        CLLocationCoordinate2DMake(51.49206920907645,-0.1028062486559567),
        CLLocationCoordinate2DMake(51.49191343643891,-0.1030471695405388),
        CLLocationCoordinate2DMake(51.49166767915873,-0.1032811364737363),
        CLLocationCoordinate2DMake(51.49157623099137,-0.103102382107817),
        
	};
    
    MKPolygon *dantePolygon=[MKPolygon polygonWithCoordinates:danteCoords count:10];


    
    CLLocationCoordinate2D lrcCoords[9]={
        
        
        CLLocationCoordinate2DMake(51.49838573434498,-0.102459502558282),
        CLLocationCoordinate2DMake(51.4984672710456,-0.1022489006564042),
        CLLocationCoordinate2DMake(51.49871660380015, -0.1025791362879847),
        CLLocationCoordinate2DMake(51.49871694340211, -0.1026070245415212),
        CLLocationCoordinate2DMake(51.49870992678741, -0.1026178538296474),
        CLLocationCoordinate2DMake(51.49869790216525, -0.1027834072532674),
        CLLocationCoordinate2DMake(51.49870421249005, -0.1028182707396152),
        CLLocationCoordinate2DMake(51.49868094586091,-0.1028335177372997),
        CLLocationCoordinate2DMake(51.49838573434498, -0.102459502558282),
        
	};
    
    MKPolygon *lrcPolygon=[MKPolygon polygonWithCoordinates:lrcCoords count:9];
    
    CLLocationCoordinate2D admissionCoords[11]={
        
        
        CLLocationCoordinate2DMake(51.49648077573332,-0.1017332714431074),
        CLLocationCoordinate2DMake(51.49669956281952,-0.1013065327693397),
        CLLocationCoordinate2DMake(51.49710303178366,-0.1011158337369944),
        CLLocationCoordinate2DMake(51.49719543308719,-0.1012431133617242),
        CLLocationCoordinate2DMake(51.49709319509954,-0.1014311389976752),
        CLLocationCoordinate2DMake(51.49706262670752,-0.1013920179745642),
        CLLocationCoordinate2DMake(51.49677529480945,-0.101526504732794),
        CLLocationCoordinate2DMake(51.49670163433356,-0.1016934986628681),
        CLLocationCoordinate2DMake(51.49680665350051,-0.1018271299018325),
        CLLocationCoordinate2DMake(51.4967201344672, -0.1020365154632419),
        CLLocationCoordinate2DMake(51.49648077573332,-0.1017332714431074),
        
	};
    
    MKPolygon *admissionsPolygon=[MKPolygon polygonWithCoordinates:admissionCoords count:11];

    CLLocationCoordinate2D technoCoords[9]={
        
        
        CLLocationCoordinate2DMake(51.49671751802899, -0.1020362928782115),
        CLLocationCoordinate2DMake(51.49680680918926, -0.1018310139468681),
        CLLocationCoordinate2DMake(51.49694171747621, -0.1019908283336424),
        CLLocationCoordinate2DMake(51.49716329870071, -0.1015323695321502),
        CLLocationCoordinate2DMake(51.49709607092055, -0.1014223971488604),
        CLLocationCoordinate2DMake(51.4971949457464, -0.1012301107794733),
        CLLocationCoordinate2DMake(51.49743244476623, -0.1015471233491883),
        CLLocationCoordinate2DMake(51.49700731437589,-0.1023997581796476),
        CLLocationCoordinate2DMake(51.49671751802899, -0.1020362928782115),

        
	};
    
    MKPolygon *technoPolygon=[MKPolygon polygonWithCoordinates:technoCoords count:9];

    CLLocationCoordinate2D perryCoords[9]={
        
        
        CLLocationCoordinate2DMake(-0.1003448030317822,51.496688812957),
        CLLocationCoordinate2DMake(-0.100382278609743,51.49661760469205),
        CLLocationCoordinate2DMake(-0.1003460091473496,51.49660193079811),
        CLLocationCoordinate2DMake(-0.1003825976716899,51.49653553921659),
        CLLocationCoordinate2DMake(-0.1000840613434417,51.49646134728494),
        CLLocationCoordinate2DMake(-0.09993845089650177,51.4966806346487),
        CLLocationCoordinate2DMake(-0.1006058136430366,51.49683406263909),
        CLLocationCoordinate2DMake(-0.1006491717972435,51.49676793989959),
        CLLocationCoordinate2DMake(-0.1003448030317822,51.496688812957),
        
        
	};
    
    MKPolygon *perryPolygon=[MKPolygon polygonWithCoordinates:perryCoords count:9];
    



    [self addBuildingWithName:@"Admissions and Recruitment" type:@"Facility" address:@"123 Fictional Street, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:admissionsPolygon andImagePath:@""];
//    [self addBuildingWithName:@"Borough Road" type:@"Business Faculty" address:@"Borough Road, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:faradayPolygon  andImagePath:@""];
//    [self addBuildingWithName:@"Caxton House" type:@"Facility" address:@"124 Fictional Street, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:faradayPolygon andImagePath:@""];
    [self addBuildingWithName:@"Faraday Wing" type:@"Business Faculty" address:@"Keyworth Street, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:faradayPolygon andImagePath:@"faraday.png"];

    [self addBuildingWithName:@"Keyworth Centre" type:@"Business Faculty" address:@"Keyworth Street, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:keyworthPolygon  andImagePath:@"keyworth.png"];
    [self addBuildingWithName:@"London Road Building" type:@"Arts and Human Sciences Faculty" address:@"90 London Road, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:londonRoadPolygon  andImagePath:@"londonroad.png"];
    [self addBuildingWithName:@"McClaren House" type:@"Residence" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:mclarenPolygon  andImagePath:@"mclaren.png"];
    

    [self addBuildingWithName:@"Technopark" type:@"Facility" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Havering" contact:@"020 7815 7815" polygon:technoPolygon  andImagePath:@"mclaren.png"];

    
    [self addBuildingWithName:@"LRC" type:@"Facility" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:lrcPolygon  andImagePath:@"mclaren.png"];

    
    [self addBuildingWithName:@"Dante Road" type:@"Residence" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:dantePolygon  andImagePath:@"mclaren.png"];

    
    [self addBuildingWithName:@"Perry Library" type:@"Facility" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:perryPolygon  andImagePath:@"mclaren.png"];
    
    [self addBuildingWithName:@"K2" type:@"Business Faculty" address:@"1 St Georges Circus, London, SE1 0AP" campus:@"Southwark" contact:@"020 7815 7815" polygon:k2Polygon  andImagePath:@"mclaren.png"];

   // [self.masterList sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:[sightingList count]];
    self.filteredArray = filteredArray;
//    for(CNBuilding* building in self.masterList){
//    NSLog(@" Building successfully added");
//    NSLog(@" %@", building.name);
//    NSLog(@" %@", building.type);
//    NSLog(@" %@", building.address);
//    NSLog(@" %@", building.campus);
//    NSLog(@" %@", building.contact);
//        NSLog(@" %@", building.polygon.title);
//
//        NSLog(@" \n");



//    }

}
-(void)setMasterBirdSightingList:(NSMutableArray *)newList
{
    if(_masterList != newList)
    {
        _masterList=[newList mutableCopy];
    }
}



-(void) loadPolygons{
    CLLocationCoordinate2D faradayCoords[5]={
		
        CLLocationCoordinate2DMake(51.49718957003158,-0.1008453416799415),
        CLLocationCoordinate2DMake(51.49709727402367,-0.100464312684676),
        CLLocationCoordinate2DMake(51.4976161448699,-0.1003491672707524),
        CLLocationCoordinate2DMake(51.49765494273916,-0.1007516799051655),
        CLLocationCoordinate2DMake(51.49718957003158,-0.1008453416799415),
        
        
        
	};
    
    MKPolygon *faradayPolygon=[MKPolygon polygonWithCoordinates:faradayCoords count:5];
    faradayPolygon.title = @"Business";
}

-(id)init
{
    if(self=[super init])
    {
        
    }
    return self;
    
}
-(NSUInteger)countOfList{
    return [self.masterList count];
}

-(CNBuilding *)objectInListAtIndex: (NSUInteger)theIndex {
    return [self.masterList objectAtIndex:theIndex];
}

-(void)addBuildingWithName:(NSString *)theName type:(NSString*)theType address:(NSString* )theAddress campus:(NSString*)theCampus contact:(NSString*)theContact polygon:(MKPolygon *)thePolygon andImagePath:(NSString*)thePath
{
    CNAnnotation* annotation = [[CNAnnotation alloc] init];
    annotation.coordinate = thePolygon.coordinate;
    CNBuilding *building =[[CNBuilding alloc] initWithName:theName address:theAddress type:theType campus:theCampus contact:theContact polygon:thePolygon annotation:annotation andImagePath:thePath];
    annotation.title = building.name;
    annotation.subtitle = building.address;
    thePolygon.title=building.type;
    
   // [self.masterList addObject:building];
    [self.masterList addObject:building];
    
}


@end
