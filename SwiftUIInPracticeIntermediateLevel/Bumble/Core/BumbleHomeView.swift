//
//  BumbleHomeView.swift
//  SwiftUIInPracticeIntermediateLevel
//
//  Created by Hakob Ghlijyan on 03.04.2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter: String = "Everyone"
    ///sozdadim masiv gde budut vse useri ... kotorie budut pokazivatsya na ui vmesto red rec
    @State private var allUser:[User] = []
    /// eto budet nash tekuchiy index user profil.. kotoriy mi budem delat +1 chtob prereyti na sleduchiy user
    @State private var selectedIndex: Int = 0
    /// eto budet tekuchee znachenie card , on ssmechen na levo ili na pravo ... v vide slovarya [:] - eto pustoy, INt potomu chto id u user v Int vide
    /// User - > id Int -> direction R -> true , L -> false
    @State private var cardOffsets: [Int:Bool] = [:]
    @State private var currentSwipeOffset: CGFloat = 0

    
    var body: some View {
        ZStack {
            //1
            Color.bumbleWhite.ignoresSafeArea()
            //2
            VStack(spacing: 12) {
                header                                                          //1
                BumbleFilterView(options: filters, selection: $selectedFilter)  //2
                    .background(Divider(), alignment: .bottom)                  //3
                
                ZStack {
                    if !allUser.isEmpty {
                        ForEach(Array(allUser.enumerated()), id: \.offset) { (index , user) in
                            //1
                            ///enumerated , dlya togo chtob poluchit posledovotelnost userov
                            ///no ego nado v Array , offset chtob poluchit ix smeshenie
                            ///on nam dayot .. -> 2 obekta  index i user
//                            Rectangle()
//                                .fill(.red)
//                                .overlay( Text("\(index)") )
                            /// pokazivaet  0 v samom nizu a 29 na samom verxu
                            //2
                            /// tak mi xotim chtob pokazivalos tekuchiy index ... esli current index = index , to on pokajet ego
                            /// no nam na ekrane nujno ne vse user a tolko te kto seychat , potom i bili do
                            let isPrevious = (selectedIndex - 1) == index    // prediduchiy
                            let isCurrent = selectedIndex == index           // tekuchiy
                            let isNext = (selectedIndex + 1) == index        // sleduychiy
                            
                            if isPrevious || isCurrent || isNext {
                                /// nash offset , kotoriy dudet naznachtsya na true ili false
                                let offsetValue = cardOffsets[user.id]
                                
                                //1
                                /*
                                 Rectangle()
                                     .fill(index == 0 ? .red : .blue)
                                     .overlay( Text("\(index)") )
                                     .withDragGesture(
                                         .horizontal,                   //vid peretaskivaniya
 //                                        minimumDistance: 0,
                                         resets: true,                  //vid vozrochaetsya nazad -> true
                                         rotationMultiplier: 1.05,      //pri smechenii budet povorot
                                         onChanged: { dragOffset in     //pri peremechenii
                                             
                                         },
                                         onEnded: { dragOffset in       //pri okonchanii pereecheniya
                                             // zdesmi naznachim v offset znachenie na kotoroe on poydet na R L
 //                                            offset = dragOffset.width  // -50 ili 50
                                             
                                             if dragOffset.width < -50 {    // esli on budet menche -50
                                                 userDidSelect(index: index, isLike: false)  // to on delaet X No
                                             } else if dragOffset.width > 50 {
                                                 userDidSelect(index: index, isLike: true)  // to on delaet V Yes
                                             }
                                         }
                                     )
                                 */
                                userProfileCell(user: user, index: index)   //teper grag gester imeet prioritet...->
                                    .zIndex(Double(allUser.count - index))
                                ///kajdomu prisvoivaem svoy index , naprimenr -> elis tam 100 - 0 = 100
//                                    .offset(x: -900)   /// on smestit na pravo ili na levo to kotoriy viden
                                /// sdes mi smotrim offsetValue raven  nil , to mi ne smaxivaem , a esli on true to 900 v pravo , false na levo
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 900 : -900)
                            }
                            
                        }
                    } else {
                        ProgressView()
                    }
                    
                    //2 etot sloy bdet dlya indicatorov X V  . rec budet no ne viden... po umolchaniyu on z index 1 , dlya etog mi naznachim 999999 , chtob vien bil
                    //1v
                    /*
                     ZStack {
                         // 1 - xmark
                         Circle()
                             .fill(.bumbleGray.opacity(0.4))
                             .overlay(
                             Image(systemName: "xmark")
                                 .font(.title)
                                 .fontWeight(.semibold)
                             )
                             .frame(width: 60, height: 60)
                             .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)  // absolut znachenie ono - ili + .. on vzmet i zdelaet ego nemnogo bolche, pri smechenii na 100 on 1,5 maschtab a esli net to on budet togo je razmera.
                             .offset(x: min(-currentSwipeOffset, 150))  //delaem minimalniy 150 , posle nego on ne dvinetsya
                             .offset(x: -100)
                             .frame(maxWidth: .infinity, alignment: .leading)
                         //2
                         Circle()
                             .fill(.bumbleGray.opacity(0.4))
                             .overlay(
                             Image(systemName: "checkmark")
                                 .font(.title)
                                 .fontWeight(.semibold)
                             )
                             .frame(width: 60, height: 60)
                             .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)  // absolut znachenie ono - ili + .. on vzmet i zdelaet ego nemnogo bolche, pri smechenii na 100 on 1,5 maschtab a esli net to on budet togo je razmera.
                             .offset(x: max(-currentSwipeOffset, -150))  //delaem minimalniy 150 , posle nego on ne dvinetsya
                             .offset(x: 100)
                             .frame(maxWidth: .infinity, alignment: .trailing)
                     }
                     .zIndex(9999999)
                     */
                    //2v
                    overlaySwipingIndicator
                        .zIndex(9999999)
                }
                .frame(maxHeight: .infinity) ///tak nach frame budet , daje esli tam nichego net
                ///dobavi animation chtob etot perexod bil plavnee , animu=iruem cardOffsets smenu etogo znacheniya
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar) ///chtob on v stack bil skrit
    }
}

#Preview {
        BumbleHomeView()
}

//some View
extension BumbleHomeView {
    private var header: some View {
        HStack(spacing: 0.0) {
            //1
            HStack(spacing: 0.0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture {    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0))
                    .onTapGesture {   
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //2
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            //3
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0))
                .onTapGesture {  
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    //1v
    /*
     private func userProfileCell(index: Int) -> some View {
         Rectangle()
             .fill(index == 0 ? .red : .blue)
             .overlay( Text("\(currentSwipeOffset)").foregroundStyle(.white) )
             .withDragGesture(
                 .horizontal,                   //vid peretaskivaniya
                 //                                        minimumDistance: 0,
                 resets: true,                  //vid vozrochaetsya nazad -> true
                 rotationMultiplier: 1.05,      //pri smechenii budet povorot
                 onChanged: { dragOffset in     //pri peremechenii
                     //
                     currentSwipeOffset = dragOffset.width
                 },
                 onEnded: { dragOffset in       //pri okonchanii pereecheniya
                     // zdesmi naznachim v offset znachenie na kotoroe on poydet na R L
                     //                                            offset = dragOffset.width  // -50 ili 50
                     
                     if dragOffset.width < -50 {    // esli on budet menche -50
                         userDidSelect(index: index, isLike: false)  // to on delaet X No
                     } else if dragOffset.width > 50 {
                         userDidSelect(index: index, isLike: true)  // to on delaet V Yes
                     }
                 }
             )
     }
     */
    //v2
    private func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            user: user,    // peredadim user
            onSendAComplimentPresed: nil,
            onSuperLikePresed: nil,
            onXmarkLikePresed: {    // eto budet toje samoe chto i smaxivanie - > false
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPresed: {    // eto budet toje samoe chto i smaxivanie - > true
                userDidSelect(index: index, isLike: true)
            },
            onHideAndRaportPresed: nil
        )
        .withDragGesture(
            .horizontal,                   //vid peretaskivaniya
            minimumDistance: 20,          //teper grag gester imeet prioritet...-> on ne dayot scrol view rabotat, takim , nujno sdelat min distanse naprimer 10 .. chtob on znal kogda rabotal draggesture a congda scroll v view, tak chto on esli sdvinul minium menche > 10 v levo iliv pravo, to on ne budet rabotat drag , a scroll zarabotaet. 0 ne rabotaet , a 20 zarabtaet
            resets: true,                  //vid vozrochaetsya nazad -> true
            rotationMultiplier: 1.05,      //pri smechenii budet povorot
            onChanged: { dragOffset in     //pri peremechenii
                //
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in       //pri okonchanii pereecheniya
                // zdesmi naznachim v offset znachenie na kotoroe on poydet na R L
                //                                            offset = dragOffset.width  // -50 ili 50
                
                if dragOffset.width < -50 {    // esli on budet menche -50
                    userDidSelect(index: index, isLike: false)  // to on delaet X No
                } else if dragOffset.width > 50 {
                    userDidSelect(index: index, isLike: true)  // to on delaet V Yes
                }
            }
        )
    }
    
    private var overlaySwipingIndicator: some View {
        ZStack {
            // 1 - xmark
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                Image(systemName: "xmark")
                    .font(.title)
                    .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)  // absolut znachenie ono - ili + .. on vzmet i zdelaet ego nemnogo bolche, pri smechenii na 100 on 1,5 maschtab a esli net to on budet togo je razmera.
                .offset(x: min(-currentSwipeOffset, 150))  //delaem minimalniy 150 , posle nego on ne dvinetsya
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            //2
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                Image(systemName: "checkmark")
                    .font(.title)
                    .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)  // absolut znachenie ono - ili + .. on vzmet i zdelaet ego nemnogo bolche, pri smechenii na 100 on 1,5 maschtab a esli net to on budet togo je razmera.
                .offset(x: max(-currentSwipeOffset, -150))  //delaem minimalniy 150 , posle nego on ne dvinetsya
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
}

//Funcs
/// u nas tak je budet func v kotoroy mi budem poluchat vsex user
/// i onbudet vivan v .task ...
/// v func mi snachalo proveryaem chto all user uje zagrujani . ili elsli net to delaem to chto posle guard a ->
extension BumbleHomeView {
    private func getData() async {
        guard allUser.isEmpty else { return }
        do {
            allUser = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUser[index]                   // nash user kotoriy na ekrane.. ego index
        cardOffsets[user.id] = isLike               // nash smechenie islike budet true to [user.id] peredastsya true
        
        selectedIndex += 1                          // etim mi skajem ne vajo chto bilo true ili false , emu pribavim +1 chtob pereyti na sleduchego user , to est pokazat next user... on stanet po seredine , a to kotoroe smaxnuli ili poka ostanetsya  , budet ili R ili L
    }
}
