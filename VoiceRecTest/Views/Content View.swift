import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @ObservedObject var audioRecorder = AudioRecorder()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default
    )
    
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            RecordingsList(audioPlayer: audioPlayer)
                .safeAreaInset(edge: .bottom) {
                    bottomBar
                }
                .navigationTitle("Voice Recorder")
        }
    }
    
    var bottomBar: some View {
        VStack {
            PlayerBar(audioPlayer: audioPlayer)
            RecorderBar(audioPlayer: audioPlayer)
        }
        .background(.thinMaterial)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
