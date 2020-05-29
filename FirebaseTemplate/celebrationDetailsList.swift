//
//  celebrationDetailsList.swift
//  ListProject
//
//  Created by Shaimaa on 5/17/20.
//  Copyright © 2020 Alyaa. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct CelebrationList : Codable, Hashable, Identifiable {
    var lista : Lista
        var id : String
 //   var id = UUID()
 //   var picture : UIImage? = UIImage(systemName: "camera.circle")
    var gifts : [GiftsList]
    var decoration : [DecorationList]
    var clothesAccessories : [ClothesList]
    var other : [OtherList]
}

struct GiftsList : Codable, Hashable, Identifiable{
    var name : String
    var price : String = ""
  //  var id = UUID()
        var id : String
}

struct DecorationList : Codable, Hashable, Identifiable{
    var name : String
    var price : String = ""
  //  var id = UUID()
        var id : String
}

struct ClothesList : Codable, Hashable, Identifiable{
    var name : String
    var price : String = ""
  //  var id = UUID()
        var id : String
}

struct OtherList : Codable, Hashable, Identifiable{
    var name : String
    var price : String = ""
   // var id = UUID()
        var id : String
}

enum whenClick13 {
    case plus
    case minus
    mutating func toggleClick(){
        switch self {
        case .plus : self = .minus
        case .minus : self = .plus
        }
    }
    func textNameClick() -> String {
        switch self {
        case .plus : return "plus.circle"
        case .minus : return "minus.circle"
        }
    }
}

struct celebrationDetailsList: View {
    @EnvironmentObject var env: Env
    
    @State var whenClickGift = whenClick13.plus
    @State var whenClickDecoration = whenClick13.plus
    @State var whenClickClothes = whenClick13.plus
    @State var whenClickOther = whenClick13.plus
    @State var isClickGift = false
    @State var isClickDecoration = false
    @State var isClickClothes = false
    @State var isClickOther = false
    @State var listGift : String = ""
    @State var listDec : String = ""
    @State var listCAndA : String = ""
    @State var listOther : String = ""
    @State var newNameGift : String = ""
    @State var newPriceGifts : String = ""
    @State var newNameDec : String = ""
    @State var newPriceDec : String = ""
    @State var newNameCloth : String = ""
    @State var newPriceCloth : String = ""
    @State var newNameOth : String = ""
    @State var newPriceOth : String = ""
    @State var refreshNow = false
    @State var moveToMain = false
    @State private var showingAlert = false  // alert for save button
    
    // second new picture : from github
    @State private var image1: UIImage? = UIImage(systemName: "camera.circle")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @Binding var isEdit : Bool // this var will be passed from main list, to make the save as edit array , not new one
    
    @Environment(\.presentationMode) var presentationMode // to dismiss the sheet after update only . only for update view : for now
    
    @State var changeSaveToUpdate = "Save"  // this var for change save button text to update
    @State var changeAlertSaveToUpdate = "Your List is saved successfully" // this var for change alert save text to update
    
    @State var currencyOutput = ""
    
    @Binding var currentCelebrationList : CelebrationList
     @Binding var currentLista : Lista
    
    var body: some View {
        
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            //            NavigationLink(destination: MainList(), isActive: $moveToMain){
            //                Text("")
            //            }
            ScrollView{
                VStack{
                    // the bellow z,v,hstack for list picture
                    //                ZStack{
//                    HStack{
//                        Spacer()
//                        Image(uiImage: image1!)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: 70, height: 70)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color("blue"), lineWidth: 5))
//                            .shadow(radius: 10)
//                            .padding(.trailing, 30)
//                            .padding(.top)
//                            //.offset(y: -40)
//                            .onTapGesture { self.shouldPresentActionScheet = true }
//                            .sheet(isPresented: $shouldPresentImagePicker) {
//                                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image1, isPresented: self.$shouldPresentImagePicker)
//                        }
//                        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
//                            ActionSheet(title: Text("Take a photo or select from photo library"), message: Text(""), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
//                                self.shouldPresentImagePicker = true
//                                self.shouldPresentCamera = true
//                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
//                                self.shouldPresentImagePicker = true
//                                self.shouldPresentCamera = false
//                            }), ActionSheet.Button.cancel()])
//                        }
//                    }
                    
                    VStack{
                        
                        Text(currentCelebrationList.lista.givenName)
                            .foregroundColor(Color.black).font(.system(size: 40, weight: .bold, design: .rounded)).padding(.vertical,20)
                        
                        HStack{
                            VStack(alignment: .leading, spacing:7){
                                Text("Budget")
                                    .font(.system(size: 30))
                                Text(currentCelebrationList.lista.budget)
                                    .font(.system(size: 40))
                            }
                            Spacer()
                            VStack{
                                Text("Remaining")
                                    .font(.system(size: 30))
                                if self.currentCelebrationList.lista.remaining == ""{
                                    Text(self.currentCelebrationList.lista.budget)
                                        .font(.system(size: 40))
                                        .foregroundColor(Color.gray)
                                }
                                else{
                                    Text(currentCelebrationList.lista.remaining)
                                        .font(.system(size: 40))
                                        .foregroundColor(Color("red"))
                                }
                            }
                        }.padding(.horizontal, 20)
                    }//.offset(y: -100)
                    
                    Group{
                        HStack{
                            Button(action: {
                                self.whenClickGift.toggleClick()
                                self.isClickGift.toggle()
                            }){
                                Image(systemName:whenClickGift.textNameClick())
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color("blue"))
                                Text("Gifts").modifier(blueColorForAddTitles())
                                Spacer()
                                
                            }
                        }.padding(.horizontal)
                        if self.isClickGift {
                            VStack{
                                Group{
                                    if self.currentCelebrationList.gifts.count >= 0 {
                                        ForEach(self.currentCelebrationList.gifts, id: \.self){ i in
                                            HStack{
                                                Text(i.name)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 190, height: 30, alignment: .center)
                                                
                                                Spacer()
                                                Text(i.price)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 100, height: 30, alignment: .center)
                                                
                                            }.padding(.vertical,5)
                                                .frame(width: 370, height: 40)
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(radius: 5)
                                                .padding(.bottom, 10)
                                        }
                                        if refreshNow{
                                            Text(newNameGift)
                                                .modifier(blueColorForAddTitles())
                                        }
                                    }
                                }.padding(.horizontal, 15)
                                HStack{
                                    TextField("Enter Item..", text: self.$newNameGift)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Enter price", text: self.$newPriceGifts)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color(.white))
                                        .frame(width: 30, height: 30)
                                        .background(Color("blue"))
                                        .clipShape(Circle())
                                        .padding(.vertical,10)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            if (self.newNameGift == "" && self.newPriceGifts == "")
                                            { }  // if both field empty
                                            else if (self.newNameGift == ""){
                                            }  // only name empty
                                            else{
                                                if (self.newPriceGifts == ""){
                                                    self.newPriceGifts = "0.0"
                                                } // only price empty will continue
                                                self.refreshNow = true
                                                self.currentCelebrationList.gifts.append(GiftsList(name: self.newNameGift, price: self.newPriceGifts, id: ""))
                                                self.calculateTheRemainig(prc: self.newPriceGifts)
                                                print(self.currentCelebrationList.gifts)
                                                self.newNameGift = ""
                                                self.newPriceGifts = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                self.refreshNow = false
                                            }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    Group{
                        HStack{
                            Button(action: {
                                self.whenClickDecoration.toggleClick()
                                self.isClickDecoration.toggle()
                            }){
                                Image(systemName:whenClickDecoration.textNameClick())
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color("blue"))
                                Text("Home Decorations").modifier(blueColorForAddTitles())
                                Spacer()
                            }
                        }.padding(.horizontal)
                        if self.isClickDecoration {
                            VStack{
                                Group{
                                    if self.currentCelebrationList.decoration.count >= 0 {
                                        ForEach(self.currentCelebrationList.decoration, id: \.self){ i in
                                            HStack{
                                                Text(i.name)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 190, height: 30, alignment: .center)
                                                Spacer()
                                                Text(i.price)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 100, height: 30, alignment: .center)
                                            }.padding(.vertical,5)
                                                .frame(width: 370, height: 40)
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(radius: 5)
                                                .padding(.bottom, 10)
                                        }
                                        if refreshNow{
                                            Text(newNameDec)
                                                .modifier(blueColorForAddTitles())
                                        }
                                    }
                                }.padding(.horizontal, 15)
                                HStack{
                                    TextField("Enter Item..", text: self.$newNameDec)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Enter price..", text: self.$newPriceDec)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color(.white))
                                        .frame(width: 30, height: 30)
                                        .background(Color("blue"))
                                        .clipShape(Circle())
                                        .padding(.vertical,10)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            if (self.newNameDec == "" && self.newPriceDec == "")
                                            { }  // if both field empty
                                            else if (self.newNameDec == ""){
                                            }  // only name empty
                                            else{
                                                if (self.newPriceDec == ""){
                                                    self.newPriceDec = "0.0"
                                                } // only price empty will continue
                                                self.refreshNow = true
                                                self.currentCelebrationList.decoration.append(DecorationList(name: self.newNameDec, price: self.newPriceDec, id: ""))
                                                self.calculateTheRemainig(prc: self.newPriceDec)
                                                print(self.currentCelebrationList.decoration)
                                                self.newNameDec = ""
                                                self.newPriceDec = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                self.refreshNow = false
                                            }
                                    }
                                }
                            }
                        }
                    }
                    Group{
                        HStack{
                            Button(action: {
                                self.whenClickClothes.toggleClick()
                                self.isClickClothes.toggle()
                            }){
                                Image(systemName:whenClickClothes.textNameClick())
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color("blue"))
                                Text("Clothes & Accessories").modifier(blueColorForAddTitles())
                                Spacer()
                            }
                        }.padding(.horizontal)
                        if self.isClickClothes {
                            VStack{
                                Group{
                                    if self.currentCelebrationList.clothesAccessories.count >= 0 {
                                        ForEach(self.currentCelebrationList.clothesAccessories, id: \.self){ i in
                                            HStack{
                                                Text(i.name)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 190, height: 30, alignment: .center)
                                                Spacer()
                                                Text(i.price)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 100, height: 30, alignment: .center)
                                            }.padding(.vertical,5)
                                                .frame(width: 370, height: 40)
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(radius: 5)
                                                .padding(.bottom, 10)
                                        }
                                        if refreshNow{
                                            Text(newNameCloth)
                                                .modifier(blueColorForAddTitles())
                                        }
                                    }
                                }.padding(.horizontal, 15)
                                HStack{
                                    TextField("Clothes & Accessories", text: self.$newNameCloth)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Enter price", text: self.$newPriceCloth)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color(.white))
                                        .frame(width: 30, height: 30)
                                        .background(Color("blue"))
                                        .clipShape(Circle())
                                        .padding(.vertical,10)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            if (self.newNameCloth == "" && self.newPriceCloth == "")
                                            { }  // if both field empty
                                            else if (self.newNameCloth == ""){
                                            }  // only name empty
                                            else{
                                                if (self.newPriceCloth == ""){
                                                    self.newPriceCloth = "0.0"
                                                } // only price empty will continue
                                                self.refreshNow = true
                                                self.currentCelebrationList.clothesAccessories.append(ClothesList(name: self.newNameCloth, price: self.newPriceCloth, id: ""))
                                                self.calculateTheRemainig(prc: self.newPriceCloth)
                                                print(self.currentCelebrationList.clothesAccessories)
                                                self.newNameCloth = ""
                                                self.newPriceCloth = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                self.refreshNow = false
                                            }
                                    }
                                }
                            }
                        }
                    }
                    Group{
                        HStack{
                            Button(action: {
                                self.whenClickOther.toggleClick()
                                self.isClickOther.toggle()
                            }){
                                Image(systemName:whenClickOther.textNameClick())
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color("blue"))
                                Text("Other").modifier(blueColorForAddTitles())
                                Spacer()
                            }
                        }.padding(.horizontal)
                        if self.isClickOther {
                            VStack{
                                Group{
                                    if self.currentCelebrationList.other.count >= 0 {
                                        ForEach(self.currentCelebrationList.other, id: \.self){ i in
                                            HStack{
                                                Text(i.name)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 190, height: 30, alignment: .center)
                                                Spacer()
                                                Text(i.price)
                                                    .modifier(blueColorForAddTitles())
                                                    .frame(width: 100, height: 30, alignment: .center)
                                            }.padding(.vertical,5)
                                                .frame(width: 370, height: 40)
                                                .background(Color.white)
                                                .cornerRadius(5)
                                                .shadow(radius: 5)
                                                .padding(.bottom, 10)
                                        }
                                        if refreshNow{
                                            Text(newNameOth)
                                                .modifier(blueColorForAddTitles())
                                        }
                                    }
                                }.padding(.horizontal, 15)
                                HStack{
                                    TextField("Enter other", text: self.$newNameOth)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Enter price", text: self.$newPriceOth)
                                        .frame(width: 140, height: 30, alignment: .leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Image(systemName: "plus")
                                        .imageScale(.large)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(Color(.white))
                                        .frame(width: 30, height: 30)
                                        .background(Color("blue"))
                                        .clipShape(Circle())
                                        .padding(.vertical,10)
                                        .shadow(radius: 5)
                                        .onTapGesture {
                                            if (self.newNameOth == "" && self.newPriceOth == "")
                                            { }  // if both field empty
                                            else if (self.newNameOth == ""){
                                            }  // only name empty
                                            else{
                                                if (self.newPriceOth == ""){
                                                    self.newPriceOth = "0.0"
                                                } // only price empty will continue
                                                self.refreshNow = true
                                                self.currentCelebrationList.other.append(OtherList(name: self.newNameOth, price: self.newPriceOth, id: ""))
                                                self.calculateTheRemainig(prc: self.newPriceOth)
                                                print(self.currentCelebrationList.other)
                                                self.newNameOth = ""
                                                self.newPriceOth = ""
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                self.refreshNow = false
                                            }
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack{
                        Spacer()
                        // save
                        HStack{
                            Button(action: {
                                if self.isEdit {
                                    // func edit array .. done
                                //    var theIndexHere = 0
                               //     theIndexHere = self.editArray()
                              //      self.env.currentCelebrationList.picture = self.image1
                             //       print(" here in no function \(theIndexHere) end")
                             //       self.editUsingIndex(indexx: theIndexHere)
                                    self.CelebrationEditPost()
                                     self.env.GetAllCelebrationPosts()
                                }
                                else {
                            //        self.env.currentCelebrationList.picture = self.image1
                           //         self.env.currentCelebrationList.id = UUID()
                         //           self.env.allCelebrationLists.append(self.env.currentCelebrationList)
                         //           print(self.env.allCelebrationLists)
                                    // self.moveToMain = true
                                    self.CelebrationAddPost()
                                    self.env.taskDone = true
                                    self.env.sheetC = false
                                    self.env.itsaCelebrationList.toggle()
                                    self.presentationMode.wrappedValue.dismiss()
                                    self.currentCelebrationList.clothesAccessories = []
                                    self.currentCelebrationList.decoration = []
                                    self.currentCelebrationList.gifts = []
                                    self.currentCelebrationList.other = []
                                    self.currentCelebrationList.lista = Lista(givenName: "", budget: "", id: "", type: self.env.types[1], remaining: "")
                                     self.env.GetAllCelebrationPosts()
                                }
                                self.showingAlert = true
                            })
                            {
                                Text(changeSaveToUpdate)
                                    .fontWeight(.bold)
                                    .font(.custom("Georgia Regular", size: 25))
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 8)
                                    .foregroundColor(Color(.white))
                                    .background(Color("orange button"))
                                    .cornerRadius(20)
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text(changeAlertSaveToUpdate), message: Text(""), dismissButton: .default(Text("Back to main list")){
                                    if self.isEdit {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                    })
                            }
                            Button(action: {
                                self.env.taskDone = true
                                self.presentationMode.wrappedValue.dismiss()
                              //  print(self.env.allCelebrationLists)
                            })
                            {
                                Text("Cancel")
                                    .fontWeight(.semibold)
                                    .font(.custom("Georgia Regular", size: 25))
                                    .padding(.horizontal, 40)
                                    .padding(.vertical, 8)
                                    .foregroundColor(Color(.white))
                                    .background(Color("red"))
                                    .cornerRadius(20)
                            }
                        }.padding()
                        
                    }
                    
                }
            }
        }.onAppear {  // this on apper to change save button text to update
            if self.isEdit{
                self.changeSaveToUpdate = "Update"
                self.changeAlertSaveToUpdate = "Your List is updated successfully"
                    //   self.image1 = self.env.currentCelebrationList.picture
            }
        }
    }
    
    func calculateTheRemainig(prc : String) {
        var theRemain : Double = 0.0
        var theNewPrice : Double = 0.0
        theNewPrice = Double(prc) ?? 0.0
        if (self.currentCelebrationList.lista.budget != "" && self.currentCelebrationList.lista.remaining == ""){
            self.currentCelebrationList.lista.remaining = self.currentCelebrationList.lista.budget
            theRemain = Double(self.currentCelebrationList.lista.remaining) ?? 0.0
            self.currentCelebrationList.lista.remaining = String(theRemain-theNewPrice)
            print(theNewPrice)
        }
        else if (self.currentCelebrationList.lista.budget != "" && self.currentCelebrationList.lista.remaining != ""){
            theRemain = Double(self.currentCelebrationList.lista.remaining) ?? 0.0
            self.currentCelebrationList.lista.remaining = String(theRemain-theNewPrice)
            print(theNewPrice)
            print(self.currentCelebrationList.lista.remaining)
        }
    }
    
//    func editArray() -> Int{
//        var theIndex : Int = 0
//        if let i = env.allCelebrationLists.firstIndex(where: { $0.lista.id == self.currentCelebrationList.lista.id }) {
//            print(" this is teeeeeest ... \(env.allCelebrationLists[i]) ! with index \(i) ... yes end")
//            theIndex = i
//        }
//        return theIndex
//    }
//    
//    func editUsingIndex (indexx : Int) {
//        env.allCelebrationLists[indexx] = self.currentCelebrationList
//        print("test for update the array ... \(env.allCelebrationLists))")
//    }
    
    
    // for firebase
    
    func CelebrationEditPost(){
        let id : String
          id =  self.currentCelebrationList.id
        Networking.createItem(self.currentCelebrationList, inCollection: "Celebration", withDocumentId: id) {
                print("success document updated")
            }
    }
    
    func CelebrationAddPost()  {
    let id = UUID()
        self.currentCelebrationList.id = "\(id)"
    Networking.createItem(self.currentCelebrationList, inCollection: "Celebration", withDocumentId: "\(id)") {
            print("success document uploaded")
        }
    }

    
    
  
        
      
        
        }

// the struct bellow for modifier with blue
struct blueColorForAddTitles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Georgia Regular", size: 20))
            .foregroundColor(Color("blue"))
    }
}

// second new picture : from github
import UIKit
struct SUImagePickerView: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }
    
}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
        self._image = image
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // self.image = UIImage(uiImage: image)
            self.image = image
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
// end of second new picture : from github



//
//struct celebrationDetailsList_Previews: PreviewProvider {
//    static var previews: some View {
//        celebrationDetailsList()
//    }
//}
