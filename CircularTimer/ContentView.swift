

import SwiftUI


let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct ContentView: View {
    
    @State private var progress = 1.0
        @State private var count = 10
        @State var  isFinished = false
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        VStack {
            Text(isFinished ? "Finished" : "Not Finished")
               
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 20)
                    .shadow(color: .pink,radius: 15)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .bevel))
                    .fill(.green)
                
                
                
                
            }
            .padding()
            .rotationEffect(.degrees(270))
            .animation(.spring(), value: progress)
            .overlay(
                Text("\(count)")
                    .font(.largeTitle)
            )
            .onReceive(timer) { _ in
                if Double(count) >  progress{
                    progress -= 0.1
                    count -= 1
                }
                    
                    if progress <= 0.0 || count <= 0 {
                        isFinished = true
                        timer.upstream.connect().cancel()
                    }
                }
                
            }
            
        }
    
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
