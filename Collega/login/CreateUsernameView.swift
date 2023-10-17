//

import SwiftUI
import PhotosUI
import UIKit


struct CompleteButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension View {
    func underlineTextField() -> some View {
        self
        //.padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color.gray.opacity(0.2))
            .padding(10)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            parent.image = uiImage
            parent.isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}


struct CreateUsernameView: View {
    
    //@Binding var path: NavigationPath
    
    @State var text = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var username: String = ""
    @State private var message: String = ""
    @State private var messageColor: Color = .clear
    let existingUsernames = ["User123", "johnDoe", "alice"]
    @State private var isUsernameAvailable: Bool = false
    
    
    
    var backButtonPlacement: ToolbarItemPlacement {
#if os(iOS)
        ToolbarItemPlacement.navigationBarLeading
#else
        ToolbarItemPlacement.navigation
#endif
    }
    struct CustomTextField: UIViewRepresentable {
        @Binding var text: String
        var placeholder: String
        
        func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            textField.delegate = context.coordinator
            return textField
        }
        
        func updateUIView(_ uiView: UITextField, context: Context) {
            uiView.text = text
            
            // Set placeholder color
            uiView.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
            // Set text color
            uiView.textColor = .black
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UITextFieldDelegate {
            var parent: CustomTextField
            
            init(_ parent: CustomTextField) {
                self.parent = parent
            }
            
            func textFieldDidChangeSelection(_ textField: UITextField) {
                parent.text = textField.text ?? ""
            }
        }
    }
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    func checkUsernameAvailability() {
        if username.count <= 5 {
            message = "Username must be more than 5 characters"
            messageColor = .red
            isUsernameAvailable = false
        } else if existingUsernames.contains(username) {
            message = "Cannot use"
            messageColor = .red
            isUsernameAvailable = false
        } else {
            message = "You can use this username"
            messageColor = .blue
            isUsernameAvailable = true
        }
    }
    
    var body: some View {
        
        NavigationStack {
            Spacer(minLength: 10)
            ZStack{
                Color.white.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Spacer()
                        VStack {
                            Image(uiImage: image ?? UIImage(named: "profile_photo")!)
                                .resizable()
                            //.scaledToFit()
                                .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                                .frame(width: 150, height: 150)
                            
                                .overlay(Image("picture")
                                    .resizable()
                                    .frame(width: 50 , height: 50)
                                    .clipShape(.circle)
                                    .overlay(
                                        Circle()
                                            .stroke(.gray.opacity(0.2), lineWidth: 2)
                                    )
                                        .offset(x: 55.0, y: 55.0)
                                        .onTapGesture {
                                            self.showingImagePicker = true
                                            self.sourceType = .photoLibrary
                                            self.showingImagePicker = true
                                        }
                                         
                                )
                            
                            
                            
                            /*
                             Button("Take Photo") {
                             self.sourceType = .camera
                             self.showingImagePicker = true
                             }*/
                        }
                        .padding()
                        .sheet(isPresented: $showingImagePicker, content: {
                            ImagePicker(image: $image, isShown: $showingImagePicker, sourceType: sourceType)
                        })
                        Spacer()
                    }
                    
                    Text("Username")
                        .font(.headline)
                        .padding([.leading, .trailing], 30)
                    
                    
                    //Spacer()
                    VStack(alignment: .leading) {
                        CustomTextField(text: $username, placeholder: "Please enter your name")
                            .frame(height: 40)
                            .padding([.leading, .trailing], 30)
                            .overlay(
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                    .padding([.leading, .trailing], 30),
                                alignment: .bottom
                            )
                            .onChange(of: username, perform: { value in
                                checkUsernameAvailability()
                            })
                        HStack{
                            
                            Text(message)
                                .foregroundColor(messageColor)
                            
                        }.padding([.leading, .trailing], 15)
                            .padding(.leading)
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("complete")
                                .font(
                                    Font.custom("Anek Telugu", size: 17).weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 26, alignment: .center)
                            
                                .frame(width: 345, height: 54)
                                .background(isUsernameAvailable ? Color.orange : Color.gray)
                            
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 0.5)
                                        .stroke(Color(red: 0.8, green: 0.8, blue: 0.8), lineWidth: 1)
                                )
                            
                            
                            
                            
                        }.padding([.leading, .trailing])
                            .disabled(!isUsernameAvailable)
                            .buttonStyle(CompleteButton())
                        
                        
                        
                        Spacer()
                        
                    }
                    
                    
                }
                
            }
            .navigationTitle("Create Username")
            .navigationBarTitleDisplayMode(.inline)
            
            //.navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: backButtonPlacement) {
                    Button {
                        //path.removeLast()
                    } label: {
                        Image("close")
                    }
                }
            }
            
            
        }
        
    }
}

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView()
        
    }
}
