//
//  TextFieldView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/24.
//

import SwiftUI

struct TextFieldView: View {
    
    @State
    private var email = ""
    
    @State
    private var password = ""
    
    @FocusState
    private var emailFocusState: Bool
    
    @FocusState
    private var passwordFocusState: Bool
    
    var body: some View {
       
        ZStack {
            
            VStack(alignment: .center) {
                
                TextField("email", text: $email)
                    .disableAutocorrection(true)
                    .foregroundColor(.orange)
                    .font(.system(size: 20, design: .rounded))
                    .keyboardType(.emailAddress)
                    .padding()
                    .focused($emailFocusState)
                    .showClearButton($email)
                
                Divider()
                    .overlay(emailFocusState ? .red : .gray)
                
                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding()
                    .focused($passwordFocusState)
                
                Spacer()
                    .frame(height: 50)
                
                Button(action: {
                    
                    hideKeyboard()
                    
                }, label: {
                    
                    Text("go")
                    
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(.white)
        .onTapGesture {
            // 需要添加颜色才能被点击
            ILog.debug(tag: #file, content: "???")
            hideKeyboard()
        }
        
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
