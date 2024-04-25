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

//withDragGesture
/*
 
 
 struct DragGestureViewModifier: ViewModifier {
     
     @State private var offset: CGSize = .zero
     @State private var lastOffset: CGSize = .zero
     @State private var rotation: Double = 0
     @State private var scale: CGFloat = 1

     let axes: Axis.Set
     let minimumDistance: CGFloat
     let resets: Bool
     let animation: Animation
     let rotationMultiplier: CGFloat
     let scaleMultiplier: CGFloat
     let onChanged: ((_ dragOffset: CGSize) -> ())?
     let onEnded: ((_ dragOffset: CGSize) -> ())?

     init(
         _ axes: Axis.Set = [.horizontal, .vertical],
         minimumDistance: CGFloat = 0,
         resets: Bool,
         animation: Animation,
         rotationMultiplier: CGFloat = 0,
         scaleMultiplier: CGFloat = 0,
         onChanged: ((_ dragOffset: CGSize) -> ())?,
         onEnded: ((_ dragOffset: CGSize) -> ())?) {
             self.axes = axes
             self.minimumDistance = minimumDistance
             self.resets = resets
             self.animation = animation
             self.rotationMultiplier = rotationMultiplier
             self.scaleMultiplier = scaleMultiplier
             self.onChanged = onChanged
             self.onEnded = onEnded
         }
         
     func body(content: Content) -> some View {
         content
             .scaleEffect(scale)
             .rotationEffect(Angle(degrees: rotation), anchor: .center)
             .offset(getOffset(offset: lastOffset))
             .offset(getOffset(offset: offset))
             .simultaneousGesture(
                 DragGesture(minimumDistance: minimumDistance, coordinateSpace: .global)
                     .onChanged({ value in
                         onChanged?(value.translation)
                         
                         withAnimation(animation) {
                             offset = value.translation
                             
                             rotation = getRotation(translation: value.translation)
                             scale = getScale(translation: value.translation)
                         }
                     })
                     .onEnded({ value in
                         if !resets {
                             onEnded?(lastOffset)
                         } else {
                             onEnded?(value.translation)
                         }

                         withAnimation(animation) {
                             offset = .zero
                             rotation = 0
                             scale = 1
                             
                             if !resets {
                                 lastOffset = CGSize(
                                     width: lastOffset.width + value.translation.width,
                                     height: lastOffset.height + value.translation.height)
                             } else {
                                 onChanged?(offset)
                             }
                         }
                     })
             )
     }
     
     
     private func getOffset(offset: CGSize) -> CGSize {
         switch axes {
         case .vertical:
             return CGSize(width: 0, height: offset.height)
         case .horizontal:
             return CGSize(width: offset.width, height: 0)
         default:
             return offset
         }
     }
     
     private func getRotation(translation: CGSize) -> CGFloat {
         let max = UIScreen.main.bounds.width / 2
         let percentage = translation.width * rotationMultiplier / max
         let maxRotation: CGFloat = 10
         return percentage * maxRotation
     }
     
     private func getScale(translation: CGSize) -> CGFloat {
         let max = UIScreen.main.bounds.width / 2
         
         var offsetAmount: CGFloat = 0
         switch axes {
         case .vertical:
             offsetAmount = abs(translation.height + lastOffset.height)
         case .horizontal:
             offsetAmount = abs(translation.width + lastOffset.width)
         default:
             offsetAmount = (abs(translation.width + lastOffset.width) + abs(translation.height + lastOffset.height)) / 2
         }
         
         let percentage = offsetAmount * scaleMultiplier / max
         let minScale: CGFloat = 0.8
         let range = 1 - minScale
         return 1 - (range * percentage)
     }
     
 }

 public extension View {
     
     /// Add a DragGesture to a View.
     ///
     /// DragGesture is added as a simultaneousGesture, to not interfere with other gestures Developer may add.
     ///
     /// - Parameters:
     ///   - axes: Determines the drag axes. Default allows for both horizontal and vertical movement.
     ///   - resets: If the View should reset to starting state onEnded.
     ///   - animation: The drag animation.
     ///   - rotationMultiplier: Used to rotate the View while dragging. Only applies to horizontal movement.
     ///   - scaleMultiplier: Used to scale the View while dragging.
     ///   - onEnded: The modifier will handle the View's offset onEnded. This escaping closure is for Developer convenience.
     ///
     func withDragGesture(
         _ axes: Axis.Set = [.horizontal, .vertical],
         minimumDistance: CGFloat = 0,
         resets: Bool = true,
         animation: Animation = .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.0),
         rotationMultiplier: CGFloat = 0,
         scaleMultiplier: CGFloat = 0,
         onChanged: ((_ dragOffset: CGSize) -> ())? = nil,
         onEnded: ((_ dragOffset: CGSize) -> ())? = nil) -> some View {
             modifier(DragGestureViewModifier(axes, minimumDistance: minimumDistance, resets: resets, animation: animation, rotationMultiplier: rotationMultiplier, scaleMultiplier: scaleMultiplier, onChanged: onChanged, onEnded: onEnded))
     }
     
 }
 
 
 */

//ScrollViewWithOnScrollChanged -> in LocationReader -> in FrameReader....
/*
 
 @available(iOS 14, *)
 public struct ScrollViewWithOnScrollChanged<Content:View>: View {
     
     let axes: Axis.Set
     let showsIndicators: Bool
     let content: Content
     let onScrollChanged: (_ origin: CGPoint) -> ()
     @State private var coordinateSpaceID: String = UUID().uuidString
     
     public init(
         _ axes: Axis.Set = .vertical,
         showsIndicators: Bool = false,
         @ViewBuilder content: () -> Content,
         onScrollChanged: @escaping (_ origin: CGPoint) -> ()) {
             self.axes = axes
             self.showsIndicators = showsIndicators
             self.content = content()
             self.onScrollChanged = onScrollChanged
         }
     
     public var body: some View {
         ScrollView(axes, showsIndicators: showsIndicators) {
             LocationReader(coordinateSpace: .named(coordinateSpaceID), onChange: onScrollChanged)
             content
         }
         .coordinateSpace(name: coordinateSpaceID)
     }
 }

 @available(iOS 14, *)
 struct ScrollViewWithOnScrollChanged_Previews: PreviewProvider {
     
     struct PreviewView: View {
         
         @State private var yPosition: CGFloat = 0

         var body: some View {
             ScrollViewWithOnScrollChanged {
                 VStack {
                     ForEach(0..<30) { x in
                         Text("x: \(x)")
                             .frame(maxWidth: .infinity)
                             .frame(height: 200)
                             .cornerRadius(10)
                             .background(Color.red)
                             .padding()
                             .id(x)
                     }
                 }
             } onScrollChanged: { origin in
                 yPosition = origin.y
             }
             .overlay(Text("Offset: \(yPosition)"))
         }
     }
     
     static var previews: some View {
         PreviewView()
     }
 }

 
 */

//LocationReader
/*
 
 @available(iOS 14, *)
 /// Adds a transparent View and read it's center point.
 ///
 /// Adds a GeometryReader with 0px by 0px frame.
 public struct LocationReader: View {
     
     let coordinateSpace: CoordinateSpace
     let onChange: (_ location: CGPoint) -> Void

     public init(coordinateSpace: CoordinateSpace, onChange: @escaping (_ location: CGPoint) -> Void) {
         self.coordinateSpace = coordinateSpace
         self.onChange = onChange
     }
     
     public var body: some View {
         FrameReader(coordinateSpace: coordinateSpace) { frame in
             onChange(CGPoint(x: frame.midX, y: frame.midY))
         }
         .frame(width: 0, height: 0, alignment: .center)
     }
 }

 @available(iOS 14, *)
 public extension View {
     
     /// Get the center point of the View
     ///
     /// Adds a 0px GeometryReader to the background of a View.
     func readingLocation(coordinateSpace: CoordinateSpace = .global, onChange: @escaping (_ location: CGPoint) -> ()) -> some View {
         background(LocationReader(coordinateSpace: coordinateSpace, onChange: onChange))
     }
     
 }

 @available(iOS 14, *)
 struct LocationReader_Previews: PreviewProvider {
     
     struct PreviewView: View {
         
         @State private var yOffset: CGFloat = 0
         
         var body: some View {
             ScrollView(.vertical) {
                 VStack {
                     Text("Hello, world!")
                         .frame(maxWidth: .infinity)
                         .frame(height: 200)
                         .cornerRadius(10)
                         .background(Color.green)
                         .padding()
                         .readingLocation { location in
                             yOffset = location.y
                         }
                     
                     ForEach(0..<30) { x in
                         Text("")
                             .frame(maxWidth: .infinity)
                             .frame(height: 200)
                             .cornerRadius(10)
                             .background(Color.green)
                             .padding()
                     }
                 }
             }
             .coordinateSpace(name: "test")
             .overlay(Text("Offset: \(yOffset)"))
         }
     }

     static var previews: some View {
         PreviewView()
     }
 }

 
 */

//FrameReader
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

 @available(iOS 14, *)
 struct FrameReader_Previews: PreviewProvider {
     
     struct PreviewView: View {
         
         @State private var yOffset: CGFloat = 0
         
         var body: some View {
             ScrollView(.vertical) {
                 VStack {
                     Text("")
                         .frame(maxWidth: .infinity)
                         .frame(height: 200)
                         .cornerRadius(10)
                         .background(Color.green)
                         .padding()
                         .readingFrame { frame in
                             yOffset = frame.minY
                         }
                     
                     ForEach(0..<30) { x in
                         Text("")
                             .frame(maxWidth: .infinity)
                             .frame(height: 200)
                             .cornerRadius(10)
                             .background(Color.green)
                             .padding()
                     }
                 }
             }
             .coordinateSpace(name: "test")
             .overlay(Text("Offset: \(yOffset)"))
         }
     }

     static var previews: some View {
         PreviewView()
     }
 }

 
*/
