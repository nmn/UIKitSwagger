//
//  AutoLayoutViewDistribution.swift
//  UIKitSwagger
//
//  Created by Sam Odom on 11/28/14.
//  Copyright (c) 2014 Swagger Soft. All rights reserved.
//

import UIKit

//  MARK: Left-to-right distribution

/**
  Convenience method for horizontally distributing two or more items without any spacing.  The constraints that are applied use the left and right side attributes of the views.
  @param        views Two or more items that are to be horizontally distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeftToRight(views: UIView...) {
    DistributeLeftToRight(views)
}

/**
  Convenience method for horizontally distributing an array of items without any spacing.  The constraints that are applied use the left and right side attributes of the views.
  @param        views An array of two or more items that are to be horizontally distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeftToRight(views: [UIView]) {
    DistributeLeftToRight(spacing: 0, views)
}

/**
  Convenience method for horizontally distributing two or more items with constant spacing.  The constraints that are applied use the left and right side attributes of the views.
  @param        views Two or more items that are to be horizontally distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeftToRight(#spacing: CGFloat, views: UIView...) {
    DistributeLeftToRight(spacing: spacing, views)
}

/**
  Convenience method for horizontally distributing an array of items with constant spacing.  The constraints that are applied use the left and right side attributes of the views.
  @param        views An array of two or more items that are to be horizontally distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeftToRight(#spacing: CGFloat, views: [UIView]) {
    DistributeViews(views, spacing, .LeftToRight)
}

//  MARK: Leading-to-trailing distribution

/**
  Convenience method for horizontally distributing two or more items without any spacing.  The constraints that are applied use the leading and trailing attributes of the views.
  @param        views Two or more items that are to be horizontally distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeadingToTrailing(views: UIView...) {
    DistributeLeadingToTrailing(views)
}

/**
  Convenience method for horizontally distributing an array of items without any spacing.  The constraints that are applied use the leading and trailing attributes of the views.
  @param        views An array of two or more items that are to be horizontally distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeadingToTrailing(views: [UIView]) {
    DistributeLeadingToTrailing(spacing: 0, views)
}

/**
  Convenience method for horizontally distributing two or more items with constant spacing.  The constraints that are applied use the leading and trailing attributes of the views.
  @param        views Two or more items that are to be horizontally distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeadingToTrailing(#spacing: CGFloat, views: UIView...) {
    DistributeLeadingToTrailing(spacing: spacing, views)
}

/**
  Convenience method for horizontally distributing an array of items with constant spacing.  The constraints that are applied use the leading and trailing attributes of the views.
  @param        views An array of two or more items that are to be horizontally distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeLeadingToTrailing(#spacing: CGFloat, views: [UIView]) {
    DistributeViews(views, spacing, .LeadingToTrailing)
}

//  MARK: Top-to-bottom distribution

/**
  Convenience method for vertically distributing two or more items without any spacing.  The constraints that are applied use the top and bottom side attributes of the views.
  @param        views Two or more items that are to be vertically distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeTopToBottom(views: UIView...) {
    DistributeTopToBottom(views)
}

/**
  Convenience method for vertically distributing an array of items without any spacing.  The constraints that are applied use the top and bottom side attributes of the views.
  @param        views An array of two or more items that are to be vertically distributed.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeTopToBottom(views: [UIView]) {
    DistributeTopToBottom(spacing: 0, views)
}

/**
  Convenience method for vertically distributing two or more items with constant spacing.  The constraints that are applied use the top and bottom side attributes of the views.
  @param        views Two or more items that are to be vertically distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeTopToBottom(#spacing: CGFloat, views: UIView...) {
    DistributeTopToBottom(spacing: spacing, views)
}

/**
  Convenience method for vertically distributing an array of items with constant spacing.  The constraints that are applied use the top and bottom side attributes of the views.
  @param        views An array of two or more items that are to be vertically distributed.
  @param        spacing Constant to use for spacing between the views.
  @discussion   The layout constraints created by this function are applied to the appropriate view.  If fewer than two items are provided, an error is thrown.
*/
public func DistributeTopToBottom(#spacing: CGFloat, views: [UIView]) {
    DistributeViews(views, spacing, .TopToBottom)
}

////////////////////////////////////////////////////////////////////////////////

private func DistributeViews(views: [UIView], spacing: CGFloat, direction: DistributionDirection) {
    AssertDistributionItemCount(views.count)

    let attributes = direction.attributePair()
    var firstItem: AutoLayoutAttributedItem
    var secondView = views[0]
    var secondItem = secondView.attributedItemForLayoutAttribute(attributes.1)
    for view in views[1..<views.endIndex] {
        firstItem = view.attributedItemForLayoutAttribute(attributes.0)
        (firstItem =* secondItem + spacing).apply()
        secondItem = view.attributedItemForLayoutAttribute(attributes.1)
    }
}

private enum DistributionDirection {
    case LeftToRight
    case LeadingToTrailing
    case TopToBottom

    private func attributePair() -> (NSLayoutAttribute, NSLayoutAttribute) {
        switch self {
        case .LeftToRight:
            return (.Left, .Right)

        case .LeadingToTrailing:
            return (.Leading, .Trailing)

        case .TopToBottom:
            return (.Top, .Bottom)
        }
    }
}

private func AssertDistributionItemCount(count: Int) {
    assert(count > 1, "Multiple views are required for distribution")
}