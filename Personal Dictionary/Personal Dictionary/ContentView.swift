import SwiftUI


struct MainOneView: View {
    
    @StateObject var settings = EnterString()
    
    var body: some View {
        TabView {
            AddWordView(progress: settings)
                .tabItem { Label("Add words", systemImage: "plus.circle.fill") }
            
            ContentOneView(progress: settings)
                .tabItem { Label("Check Log", systemImage: "app.badge.checkmark") }
        }
    }
}


struct MainOneView_Previews: PreviewProvider {
    static var previews: some View {
        MainOneView().preferredColorScheme(.dark)
    }
}


class EnterString: ObservableObject {
    @Published var score = " "
    @Published var usernames: [String] = ["hi"]
    @Published var usernames2: [String] = ["hi"]
}


struct AddWordView: View {
    @ObservedObject var progress: EnterString
    @State var username: String = ""
    @State var username2: String = ""
    
    var body: some View {
        VStack
        {
            TextField("Enter your anything you like", text: $username).multilineTextAlignment(.center).foregroundColor(Color.blue)
            TextField("Enter the definition", text: $username2).multilineTextAlignment(.center).foregroundColor(Color.blue)
            Button("Add to Log") { progress.score = username
                progress.usernames.append(username)
                progress.usernames2.append(username2)
            }
        }
    }
}

struct WordsView: View {
    @ObservedObject var progress: EnterString
    @State var word:String
    var body: some View {
        VStack
        {
            Text(word)
        }
        
    }
}
struct ContentOneView: View {
    @ObservedObject var progress: EnterString
    @State private var showingSheet = false
    var body: some View {
        VStack {
            ForEach(0..<progress.usernames.count, id: \.self)
            { i in
                Button("\(progress.usernames[i])")
                {
                    showingSheet.toggle()
                }.sheet(isPresented: $showingSheet) {
                    WordsView(progress: progress, word:progress.usernames2[i]).preferredColorScheme(.dark)
                }
            }
        }
    }
}
