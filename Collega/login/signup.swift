//

import SwiftUI

struct VerificationButton: ButtonStyle {
    var change : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .frame(width: 91.67142, height: 32)
          .cornerRadius(10)
          .overlay(
            !change ?
                RoundedRectangle(cornerRadius: 10)
                  .inset(by: 0.5)
                  .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 1)
            : nil
          )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}

struct SendButton: ButtonStyle {
    var change : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .frame(width: 91.67142, height: 32)
          .cornerRadius(10)
          .overlay(
            !change ?
                RoundedRectangle(cornerRadius: 10)
                  .inset(by: 0.5)
                  .stroke(Color(red: 0.6, green: 0.6, blue: 0.6), lineWidth: 1)
            : nil
          )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}


struct NextButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .frame(width: 345, height: 54)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
              .inset(by: 0.5)
              .stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1)
          )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    var checked : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
//            RoundedRectangle(cornerRadius: 5.0)
//               .stroke(lineWidth: 2)
//               .frame(width: 25, height: 25)
//               .cornerRadius(5.0)
//               .overlay {
                   Image(checked ? "checked_checkbox" : "unchecked_checkbox")
//               }
               .onTapGesture {
                   withAnimation(.spring()) {
                       configuration.isOn.toggle()
                   }
               }
            
            configuration.label
       }
    }
}

struct signup: View {
    let title: String
    @Binding var path: NavigationPath
//    @State var first_name: String = ""
//    @State var last_name: String = ""
    @State var email: String = ""
    @State var email_sent : Bool = false
    
    @State var code: String = ""
    @State var valid_code : Bool = false
    
    @State var password: String = ""
    @State var verify_password: String = ""
    @State var terms1 = false
    @State var terms2 = false
    @State var terms3 = false
    
    var backButtonPlacement: ToolbarItemPlacement {
            #if os(iOS)
            ToolbarItemPlacement.navigationBarLeading
            #else
            ToolbarItemPlacement.navigation
            #endif
        }
    
    var body: some View {
        VStack() {
            
            // stack for email information
            HStack() {
                // email textfield
                TextField("Email", text: $email).padding(.leading, 30.0).border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                
                Text("@purdue.edu")
                  .font(Font.custom("Anek Telugu", size: 16))
                  .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                  .padding(.trailing, 3.0)
                
                // send button
                Button(action: {
                    print("send button pressed")
                    self.email_sent.toggle()
                }) {
                    if(self.email_sent == false) {
                        Text("Send")
                            .font(Font.custom("Raleway", size: 16)
                                .weight(.medium))
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .foregroundColor(.white)
                    } else {
                        Text("Sent")
                          .font(
                            Font.custom("Raleway", size: 16)
                              .weight(.medium)
                          )
                          .foregroundColor(Color(red: 1, green: 0.53, blue: 0.16))
                    }
                    
                }.padding(.trailing, 10.0).buttonStyle(VerificationButton(change : self.email_sent))
            }
            
            // stack for verification code
            HStack() {
                // code textfield
                TextField("Please enter the code", text: $code).padding(.leading, 30.0).border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                

                // check button
                Button(action: {
                    print("check button pressed")
                    self.valid_code.toggle()
                }) {
                    if(self.valid_code == false) {
                        Text("check")
                            .font(Font.custom("Raleway", size: 16)
                                .weight(.medium))
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .foregroundColor(.white)
                    } else {
                        Image("check")
                    }
                    
                }.padding(.trailing, 10.0)
                    .buttonStyle(VerificationButton(change : self.valid_code))
            }
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 345, height: 1)
                .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                .padding(.bottom, 15.0)
            
            
            // password textfield
            Group {
                TextField("Enter Password", text: $password).padding(.leading, 30.0).border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 345, height: 1)
                    .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                
                Text("Please enter a password with a combination of letters and numbers of 8 or more characters.")
                    .font(Font.custom("Anek Telugu", size: 7))
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 15.0)
                    .padding(.trailing, 50.0)
            }
            
            // password verification textfield
            Group {
                TextField("Verify Password", text: $verify_password).padding(.leading, 30.0).border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 345, height: 1)
                    .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                    .padding(.bottom, 15.0)
            }
            
            // Toggles for terms and conditions agreement
            Group {
                Toggle(isOn: $terms1) {
                    Text("Terms and Conditions Agreement")
                        .font(Font.custom("Anek Telugu", size: 15))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .frame(width: 250, height: 26, alignment: .leading)
                }
                .toggleStyle(CheckboxToggleStyle(checked: self.terms1))
                
                Toggle(isOn: $terms2) {
                    Text("Terms and Conditions Agreement")
                        .font(Font.custom("Anek Telugu", size: 15))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .frame(width: 250, height: 26, alignment: .leading)
                }
                .toggleStyle(CheckboxToggleStyle(checked: self.terms2))
                
                Toggle(isOn: $terms3) {
                    Text("Terms and Conditions Agreement")
                        .font(Font.custom("Anek Telugu", size: 15))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .frame(width: 250, height: 26, alignment: .leading)
                }
                .toggleStyle(CheckboxToggleStyle(checked: self.terms3))
            }
            
            // next button
            Button(action: {
                print("next")
            }) {
                Text("Next")
                    .font(
                      Font.custom("Anek Telugu", size: 17)
                        .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 26, alignment: .center)
            }.padding(.top, 30.0) .buttonStyle(NextButton())
            
        }
//        .frame(width: 393, height: 852)
//        .background(.white)
        
        // navigation title and back button
        .navigationTitle(Text(title)
//            .font(
//                Font.custom("Raleway", size: 100)
//                .weight(.bold)
//            )
//                .multilineTextAlignment(.center)
//                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
//                .frame(width: 72, height: 20, alignment: .top)
        )
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: backButtonPlacement) {
                Button {
                    path.removeLast()
                } label: {
                    Image("close")
                }
            }
        }
        .padding(.bottom, 200.0)
    }
}

//struct signup_Previews: PreviewProvider {
//    @State private var path = NavigationPath()
//    static var previews: some View {
//        signup(path: $path)
//    }
//}
