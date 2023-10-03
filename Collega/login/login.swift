//

import SwiftUI

struct LoginButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 345, height: 54)
            .background(Color(red: 1, green: 0.62, blue: 0.24))
            .cornerRadius(15)
            .overlay(
            RoundedRectangle(cornerRadius: 15)
            .inset(by: 0.5)
            .stroke(Color(red: 0.8, green: 0.8, blue: 0.8), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SignUpButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 345, height: 54)
            .background(.white)
            .cornerRadius(15)
            .overlay(
            RoundedRectangle(cornerRadius: 15)
            .inset(by: 0.5)
            .stroke(Color(red: 0.8, green: 0.8, blue: 0.8), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


struct login: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State private var path = NavigationPath()
    
    var body: some View {

        NavigationStack(path: $path) {
            
            // background
            VStack() {
                
                // logo
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 171, height: 100.55282)
                    .background(
                        Image("CAMPLE LOGO 1 2")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom, 150.0)
                            .clipped()
                    )
                
                // email textfield
                TextField("Email Address", text: $email).padding(.leading, 30.0).border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 345, height: 1)
                    .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                    .padding(.bottom, 50.0)
                
                //password textfield
                SecureField("Enter Password", text: $pass ).padding(.leading, 30.0)
                    .border(Color.white).font(Font.custom("Anek Telugu", size: 16))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 345, height: 1)
                    .background(Color(red: 0.94, green: 0.94, blue: 0.94))
                
                    .padding(.bottom, 50.0)
                
                HStack(){
                    //                Spacer()
                    // forgot password
                    Text("forgot your password?")
                        .font(Font.custom("Anek Telugu", size: 14))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .padding(.leading, 200.0)
                    
                    
                }
                
                
                
                
                // login button
                Button(action: {
                    print("email : " + email)
                    print("password : " + pass)
                }) {
                    Text("Login").font(
                        Font.custom("Anek Telugu", size: 17).weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 47, height: 26, alignment: .center)
                    
                }.padding(.top, 30.0) .buttonStyle(LoginButton())
                
                
                
                // sign up button
//                Button(action: {
//                    print("sign up button pressed")
//                    path.append("NewView")
//                })
                NavigationLink(value: "Sign Up") {
                    Text("Sign up")
                        .font(
                            Font.custom("Anek Telugu", size: 17)
                                .weight(.bold))
                        .frame(width: 345, height: 54).cornerRadius(15)
                }
                .padding(.top, 15.0)
                .buttonStyle(SignUpButton())
                
                
                .navigationDestination(for: String.self) { view in
                    signup()
                }
                
                
                
            }
            .frame(width: 393, height: 852)
            .background(.white)
            
  
        }
        
        // navigation stack
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
