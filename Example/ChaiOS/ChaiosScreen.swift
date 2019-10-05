////
////  ChaiosScreen.swift
////  ChaiOS_Example
////
////  Created by Francisco García Sierra on 5/12/18.
////  Copyright © 2018 CocoaPods. All rights reserved.
////
//
//import Foundation
//import EarlGrey
//
////Assertion wrapper over the GreyMatcher
//protocol BaseAssertions {
//    var matcher : EarlGrey.Matcher { get }
//
//    func isDisplayed()
//    func isNotDisplayed()
//    func isVisible()
//    //.......
//}
//
////Specific elements assertion
//protocol UiTextViewAssertions : BaseAssertions{
//    func hasEmptyText()
//    func hasText()
//    //....
//}
//
////Actions wrapper over the GREYElementInteraction
//protocol BaseActions {
//    var greyInteraction : GREYElementInteraction { get }
//
//    func click()
//    func longClick()
//    //...
//}
//
////Specific elements actions
//protocol ScrolleableActions : BaseActions {
//    func scroll()
//}
//
////Class to build ChaiosViews
//class ChaiosBaseView : BaseActions, BaseAssertions {
//    //should allow us to create different ChaiosViews(CheckBox, List, TextView...) with the base methods for the calls
//    //All
//    //That
//    //Any
//    //My idea is something like:
//
//
//    //class ChaiosTextView : ChaiosBaseView, UiTextViewActions, UiTextViewAssertions {
//    //class ChaiosEditText : ChaiosBaseView, UiEditTextActions, UiEditTextAssertions {
//}
//
//protocol ChaiosScreen {
//    //Should provide the static methods to create ChaiosBaseViews
//}
