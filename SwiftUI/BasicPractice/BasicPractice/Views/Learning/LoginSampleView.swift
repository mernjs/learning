import SwiftUI

struct LoginSampleView: View {
    
    @State var name = ""
    @State var password = ""
    @State var isRemember = false
    
    func onSubmit(){
        print("onSubmit ==>>", name, password)
    }
    
    var body: some View {
        ScrollView{
            
            VStack(){
                
                VStack(){
                    Text("Login")
                    Text("By signing in you are agreeing")
                }.padding(.top, 50)
                
                HStack(){
                    Text("our")
                    Link("Term and privacy policy",destination: URL(string: "https://abc.io")!)
                }
                
                HStack(){
                    Text("Login")
                    Text("Register")
                }
                
                VStack{
                    TextField("Email Address", text: $name)
                        .padding(10)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(20)
                    
                    TextField("Password", text: $password)
                        .padding(10)
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                    
                    HStack(){
                        Toggle("Remember password", isOn: $isRemember)
                        Link("Forgot Password",destination: URL(string: "https://abc.io")!)
                    }
                    .padding(.top, 10)
                    
                    Button(action: {
                        onSubmit()
                    }){
                        Text("Submit")
                            .padding(10)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    
                    Text("or connect with").padding(.top, 10)
                    
                    HStack(){
                        Image("facebook")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                print("facebook")
                            }
                        
                        Image("instagram")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                print("instagram")
                            }
                        
                        Image("linkedin")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                print("linkedin")
                            }
                    }
                    .padding(10)
                    
                    VStack(){
                        Image("bg-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                    Image("finger-print")
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Login with touch")
                }
                .padding(20)
                
            }.background(Color(red: 70/255, green: 159/255, blue: 209/255))
            
        }
        .ignoresSafeArea()
        
    }
}
