//
//  EventsViewController.m
//  TokyoOlympics
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "EventsViewController.h"
#import "EventsViewCell.h"
#import "EventsDetailViewController.h"

#import "Events.h"
#import "EventsDAO.h"

@interface EventsViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSUInteger COL_COUNT;
}

@property (strong, nonatomic) NSArray * events;

@property (strong, nonatomic) UICollectionView* collectionView;

@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    
    if (self.events == nil || [self.events count] == 0) {
        
        EventsDAO *dao = [EventsDAO sharedInstance];
        self.events = [dao findAll];
        [self.collectionView reloadData];
    }
}

- (void) setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(101, 101);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumInteritemSpacing = 1;
 
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
   
    [self.collectionView registerClass:[EventsViewCell class]  forCellWithReuseIdentifier:@"cellIdentifier" ];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    CGSize screenSize  = [UIScreen mainScreen].bounds.size;
    COL_COUNT = screenSize.width / 106;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    unsigned long num = [self.events count] % COL_COUNT;
    if (num == 0) {
        return [self.events count] / COL_COUNT;
    } else {
        return [self.events count] / COL_COUNT + 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EventsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];

    NSInteger idx = indexPath.section * COL_COUNT + indexPath.row;
    
    if (idx < self.events.count) {
        Events *event = self.events[idx];
        cell.imageView.image = [UIImage imageNamed:event.EventIcon];
    } else {
        cell.imageView.image = nil;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger idx = indexPath.section * COL_COUNT + indexPath.row;
    Events *event = self.events[idx];
    
    NSLog(@"select event name : %@", event.EventName);
    
    EventsDetailViewController *detailViewController = [[EventsDetailViewController alloc] init];
    detailViewController.event = event;
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];    
}

@end
