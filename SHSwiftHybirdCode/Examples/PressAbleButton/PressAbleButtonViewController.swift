//
//  PressAbleButtonViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/24.
//

import UIKit
import SwiftUI

class PressAbleButtonViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: PressAbleButtonViewController())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSwiftUI(anyViewWrapper: AnyView(
            
            PressAbleButtonView(buttonColor: Color.white, shadowColor: Color.gray, height: 50, shadowBottomOffset: 8, cornerRadius: 25, onClick: {
                
                ILog.debug(tag: #file, content: "click")
                
            }, contentView: AnyView(
                
                Text(String(localized: "test"))
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
            ), borderColor: Color.black).padding(.horizontal, 20)
            
        ))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

private struct PressAbleButtonView: View {
    
    var buttonColor: Color
    var shadowColor: Color
    var height: CGFloat
    var shadowBottomOffset: CGFloat
    var cornerRadius: CGFloat
    var onClick: () -> Void
    var contentView: AnyView
    var borderColor: Color = Color.clear
    
    @State
    private var isPressed = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            shadowColor
                .frame(maxWidth: .infinity, maxHeight: height + (isPressed ? (shadowBottomOffset * 0.5) : shadowBottomOffset))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .padding(.top, isPressed ? (shadowBottomOffset * 0.5) : 0)
            
            Button(action: {
                
                onClick()
                
            }, label: {

                contentView
                    .overlay {
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: 2)
                        
                    }
            })
            .frame(maxWidth: .infinity, maxHeight: height)
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .padding(.top, isPressed ? shadowBottomOffset * 0.5 : 0)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0.0)
                    .onChanged { _ in
                        
                        if self.isPressed {
                            return
                        }
                        
                        self.isPressed = true
                    }
                    .onEnded { _ in
                        self.isPressed = false
                    }
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: height + shadowBottomOffset)
        
        
    }
}

struct PressAbleButton_Previews: PreviewProvider {
    static var previews: some View {
        
        PressAbleButtonView(buttonColor: Color.white, shadowColor: Color.gray, height: 50, shadowBottomOffset: 8, cornerRadius: 25, onClick: {
            
            ILog.debug(tag: #file, content: "click")
            
        }, contentView: AnyView(
            
            Text(String(localized: "test"))
                .font(.system(size: 20))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        ), borderColor: Color.black).padding(.horizontal, 20)
    }
}
