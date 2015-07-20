//
//  OpenWeatherMapView.m
//  LessonApp
//
//  Created by hirokiumatani on 2015/06/04.
//  Copyright (c) 2015年 hirokiumatani. All rights reserved.
//

#import "OpenWeatherMapView.h"
#import "OpenWeatherMapFetcher.h"

@interface OpenWeatherMapView()
@property OpenWeatherMapFetcher *iconFetcher;
@end

@implementation OpenWeatherMapView
NSString * const CONST_DEGRESS_CENTIGRADE = @"%@℃";
- (void)setView:(OpenWeatherMapEntity *)openWeatherMapEntity
{
    _iconFetcher = [OpenWeatherMapFetcher new];
    [_iconFetcher startAsyncFetchingIconImageWithIconCd:openWeatherMapEntity.weather.icon
                                                success:^(UIImage * iconImage)
    {
        _iconImage.image = iconImage;
        _tempLabel.text = [NSString stringWithFormat:CONST_DEGRESS_CENTIGRADE,openWeatherMapEntity.temp];
        _iconFetcher = nil;
    }
                                                 failed:^(NSError *error)
    {
        _iconFetcher = nil;
    }];
}
@end
