/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2015 Google Inc.
 */

//
//  GTLAramarkHelperMenuFetcherPeriodCollection.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   aramarkHelperMenuFetcher/v1
// Description:
//   Menu Fetcher API
// Classes:
//   GTLAramarkHelperMenuFetcherPeriodCollection (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLAramarkHelperMenuFetcherPeriod;

// ----------------------------------------------------------------------------
//
//   GTLAramarkHelperMenuFetcherPeriodCollection
//

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLAramarkHelperMenuFetcherPeriodCollection : GTLCollectionObject
@property (nonatomic, retain) NSArray *items;  // of GTLAramarkHelperMenuFetcherPeriod
@property (nonatomic, copy) NSString *nextPageToken;
@end
