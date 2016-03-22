//
//  ViewController.m
//  MyQcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "ViewController.h"
#import "Qcm.h"
#import "QcmSQLiteAdapter.h"
#import "CategorySQLiteAdapter.h"
#import "CategoryQcm.h"
#import "Question.h"
#import "QuestionSQLiteAdapter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QuestionSQLiteAdapter* adapter = [QuestionSQLiteAdapter new];
    
    NSDate* date = [NSDate new];
    
    Qcm* qcm = [Qcm new];
    qcm.idServer = 12;
    qcm.name = @"Test avec catégorie";
    qcm.is_available = true;
    qcm.beginning_at = date;
    qcm.finished_at = date;
    qcm.duration = 40;
    qcm.created_at = date;
    qcm.updated_at = date;

    CategoryQcm* category = [CategoryQcm new];
    category.idServer = 90;
    category.name = @"Android";
    category.created_at = date;
    category.updated_at = date;

    qcm.category = category;
    
    Question* question = [Question new];
    question.idServer = 54;
    question.title = @"Coucou";
    question.value = 3;
    question.created_at = date;
    question.updated_at = date;
    
    question.qcm = qcm;
    
    [adapter insert:question];
    
//    NSManagedObject* qcmResult = [adapter getByIdServer:qcm.idServer];
//    if (qcmResult != nil) {
//        NSLog(@"Recherche OK");
//    }else{
//        NSLog(@"Recherche failed");
//    }
    
    NSArray* questions = [adapter getAll];
    for (Question* question in questions){
        NSLog(@"Question title: %@", question.title);
        NSLog(@"QCM name: %@", question.qcm.name);
        NSLog(@"Category name: %@", question.qcm.category.name);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
