//
//  ExtensionModifierAndView .swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 01.04.2024.
//

import SwiftUI

struct ExtensionModifierAndView_: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    ExtensionModifierAndView_()
}

// Extension Modifier and View 

// ctrl m -> on sdelaet se stroki naotdelnix

//Use this - no import SwiftFulUI

//NonLazyVGrid
/*

 
 public struct NonLazyVGrid<T, Content:View>: View {
     var columns: Int = 2
     var alignment: HorizontalAlignment = .center
     var spacing: CGFloat = 8
     let items: [T]
     @ViewBuilder var content: (T?) -> Content
     
     public init(columns: Int = 2, alignment: HorizontalAlignment = .center, spacing: CGFloat = 10, items: [T], @ViewBuilder content: @escaping (T?) -> Content) {
         self.columns = columns
         self.alignment = alignment
         self.spacing = spacing
         self.items = items
         self.content = content
     }

     private var rowCount: Int {
         Int((Double(items.count) / Double(columns)).rounded(.up))
     }
         
     public var body: some View {
         VStack(alignment: alignment, spacing: spacing, content: {
             ForEach(Array(0..<rowCount), id: \.self) { rowIndex in
                 HStack(alignment: .top, spacing: spacing, content: {
                     ForEach(Array(0..<columns), id: \.self) { columnIndex in
                         let index = (rowIndex * columns) + columnIndex
                         if index < items.count {
                             content(items[index])
                         } else {
                             content(nil)
                         }
                     }
                 })
             }
         })
     }
 }
 
 
 */


//asButton
/*
 
 
 struct ButtonStyleViewModifier: ButtonStyle {
     
     let scale: CGFloat
     let opacity: Double
     let brightness: Double
     
     func makeBody(configuration: Configuration) -> some View {
         configuration.label
             .scaleEffect(configuration.isPressed ? scale : 1)
             .opacity(configuration.isPressed ? opacity : 1)
             .brightness(configuration.isPressed ? brightness : 0)
     }
     
 //    Note: Can add onChange to let isPressed value escape.
 //    However, requires iOS 14 is not common use case.
 //    Ignoring for now.
 //        .onChange(of: configuration.isPressed) { newValue in
 //          isPressed?(newValue)
 //        }

 }

 public enum ButtonType {
     case press, opacity, tap
 }

 public extension View {
     
     /// Wrap a View in a Button and add a custom ButtonStyle.
     func asButton(scale: CGFloat = 0.95, opacity: Double = 1, brightness: Double = 0, action: @escaping () -> Void) -> some View {
         Button(action: {
             action()
         }, label: {
             self
         })
         .buttonStyle(ButtonStyleViewModifier(scale: scale, opacity: opacity, brightness: brightness))
     }
     
     @ViewBuilder
     func asButton(_ type: ButtonType = .tap, action: @escaping () -> Void) -> some View {
         switch type {
         case .press:
             self.asButton(scale: 0.975, action: action)
         case .opacity:
             self.asButton(scale: 1, opacity: 0.85, action: action)
         case .tap:
             self.onTapGesture {
                 action()
             }
         }
     }
     
 }
 
 
 */


//asStretchyHeader
/*
 
 struct StetchyHeaderViewModifier: ViewModifier {
     
     var startingHeight: CGFloat = 300
     var coordinateSpace: CoordinateSpace = .global
     
     func body(content: Content) -> some View {
         GeometryReader(content: { geometry in
             content
                 .frame(width: geometry.size.width, height: stretchedHeight(geometry))
                 .clipped()
                 .offset(y: stretchedOffset(geometry))
         })
         .frame(height: startingHeight)
     }
     
     private func yOffset(_ geo: GeometryProxy) -> CGFloat {
         geo.frame(in: coordinateSpace).minY
     }
     
     private func stretchedHeight(_ geo: GeometryProxy) -> CGFloat {
         let offset = yOffset(geo)
         return offset > 0 ? (startingHeight + offset) : startingHeight
     }
     
     private func stretchedOffset(_ geo: GeometryProxy) -> CGFloat {
         let offset = yOffset(geo)
         return offset > 0 ? -offset : 0
     }
 }

 public extension View {
     
     func asStretchyHeader(startingHeight: CGFloat) -> some View {
         modifier(StetchyHeaderViewModifier(startingHeight: startingHeight))
     }
 }

 #Preview {
     ZStack {
         Color.black.edgesIgnoringSafeArea(.all)
         
         ScrollView {
             VStack {
                 Rectangle()
                     .fill(Color.green)
                     .overlay(
                         ZStack {
                             if #available(iOS 15.0, *) {
                                 AsyncImage(url: URL(string: "https://picsum.photos/800/800"))
                             }
                         }
 //                        Image(systemName: "heart.fill")
 //                            .resizable()
 //                            .scaledToFill()
 //                            .padding(100)
                     )
                     .asStretchyHeader(startingHeight: 300)
             }
         }
     }
 }

 
 */

//readingFrame
/*
 
 @available(iOS 14, *)
 /// Adds a transparent View and read it's frame.
 ///
 /// Adds a GeometryReader with infinity frame.
 public struct FrameReader: View {
     
     let coordinateSpace: CoordinateSpace
     let onChange: (_ frame: CGRect) -> Void
     
     public init(coordinateSpace: CoordinateSpace, onChange: @escaping (_ frame: CGRect) -> Void) {
         self.coordinateSpace = coordinateSpace
         self.onChange = onChange
     }

     public var body: some View {
         GeometryReader { geo in
             Text("")
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .onAppear(perform: {
                     onChange(geo.frame(in: coordinateSpace))
                 })
                 .onChange(of: geo.frame(in: coordinateSpace), perform: onChange)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
     }
 }

 @available(iOS 14, *)
 public extension View {
     
     /// Get the frame of the View
     ///
     /// Adds a GeometryReader to the background of a View.
     func readingFrame(coordinateSpace: CoordinateSpace = .global, onChange: @escaping (_ frame: CGRect) -> ()) -> some View {
         background(FrameReader(coordinateSpace: coordinateSpace, onChange: onChange))
     }
 }
 
 */
