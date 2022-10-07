//
//  StateObjectAndObservedObjectExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/07.
//

import SwiftUI

/**
 在测试1中，当点击CountViewState或CountViewObserved内部的+1按钮时，
 无论是 StateObject 或是 ObservedObject 其都表现出一致的状态，两个View都可以正常的显示当前按钮的点击次数
 
 当点击外层刷新按钮时，CountViewState中的数值仍然正常，不过CountViewObserved中的计数值被清零了。
 查看调试信息, 当点击刷新时，CountViewObserved中的实例被重新创建了，并销毁了之前的实例，CountViewState视图并没有被重新创建，仅是重新求了body的值.
 
 而外部传入的 ObservedObject 因为生命周期是UIViewController控制的，所以不会被重新创建
 
 
 
 结论：
 通过前面三个测试的分析，进一步明确了两者之间的区别：StateObject的声命周期与当前所在View生命周期保持一致，即当View被销毁后，StateObject的数据销毁，当View被刷新时，StateObject的数据会保持
 而 ObservedObject 不被View持有，生命周期不一定与View一致，即数据可能被保持或者销毁；
 而如果 ObservedObject 是外部传入的，生命周期和 UIViewController 一致，所以数据肯定能够保持。
 */
struct Test1: View {
    
    @State
    private var count = 0
    
    private var viewModel = SOAOOExampleViewModel(type:"Pass ObservedObject")//3
    
    var body: some View {
        
        VStack {
            Text("刷新CounterView计数 :\(count)")
            
            Button("刷新") {
                count += 1
            }

            CountViewState()
                .padding()

            CountViewObserved()
                .padding()
            
            CountViewPassObserved(viewModel: viewModel)
                .padding()
        }
    }
}

/**
 测试2中，点击link进入对应的视图后通过点击+1进行计数，然后返回父视图。当再次进入link后，
 @StateObject对应的视图中计数清零，这是由于返回父视图，再次进入时会重新创建视图，所以会重新创建实例，
 不过@ObservedObject对应的视图中计数是不清零的。在这个测试中，@ObservedObject创建的实例生命周期长于当前的View。
 
 而外部传入的ObservedObject肯定不会被清零
 */
struct Test2: View {
    
    private var viewModel = SOAOOExampleViewModel(type:"Pass ObservedObject")//3
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("StateObject", destination: CountViewState())
                NavigationLink("ObservedObject", destination: CountViewObserved())
                NavigationLink("Pass ObservedObject", destination: CountViewPassObserved(viewModel: viewModel))
            }
        }
    }
}

struct StateObjectAndObservedObjectExampleView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Test1()
        
        Test2()
    }
}

//使用不同的 propertywrapper 修饰相同的 ViewModel 对象
//1，使用StateObject
private struct CountViewState:View {
    
    @StateObject
    var viewModel = SOAOOExampleViewModel(type:"StateObject")//1
    
    var body: some View {
        VStack {
            Text("StateObject count: \(viewModel.count)")
            Button("+1") {
                viewModel.count += 1
            }
        }
    }
}

//2，使用ObservedObject
private struct CountViewObserved:View {
    
    @ObservedObject
    var viewModel = SOAOOExampleViewModel(type:"ObservedObject")//2
    
    var body: some View {
        VStack {
            Text("ObservedObject count: \(viewModel.count)")
            Button("+1") {
                viewModel.count += 1
            }
        }
    }
}

//3，使用 外部传递 ObservedObject
private struct CountViewPassObserved:View{
    
    @ObservedObject
    var viewModel: SOAOOExampleViewModel
    
    var body: some View {
        VStack {
            Text("Pass ObservedObject count: \(viewModel.count)")
            Button("+1") {
                viewModel.count += 1
            }
        }
    }
}
