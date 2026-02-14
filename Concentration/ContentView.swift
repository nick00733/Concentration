import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var totalGuesses = 0
    @State private var gameMessage = ""
    private let tileBack = "⚪️"
    @State private var tiles = [
        "🚀","🌶️","🕷️","🦖",
        "🦋","🌮","🍕","🦄"
    ]
    @State private var emojiShowing = Array(repeating: false, count: 16)
    @State private var guesses: [Int] = []
    @State private var disableButtons = false
    @State private var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        VStack {
            Text("Total Guesses: \(totalGuesses)")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Spacer()
            
            VStack {
                HStack{
                    Button(emojiShowing[0] == false ? tileBack : tiles[0]){
                        let index = 0
                        buttonTapped(index: index)
                        }
                    
                    Button(emojiShowing[1] == false ? tileBack : tiles[1]){
                        let index = 1
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[2] == false ? tileBack : tiles[2]){
                        let index = 2
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[3] == false ? tileBack : tiles[3]){
                        let index = 3
                        buttonTapped(index: index)
                        }
                }
                HStack{
                    Button(emojiShowing[4] == false ? tileBack : tiles[4]){
                        let index = 4
                        buttonTapped(index: index)
                        }
                    
                    Button(emojiShowing[5] == false ? tileBack : tiles[5]){
                        let index = 5
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[6] == false ? tileBack : tiles[6]){
                        let index = 6
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[7] == false ? tileBack : tiles[7]){
                        let index = 7
                        buttonTapped(index: index)
                        }
                }
                HStack{
                    Button(emojiShowing[8] == false ? tileBack : tiles[8]){
                        let index = 8
                        buttonTapped(index: index)
                        }
                    
                    Button(emojiShowing[9] == false ? tileBack : tiles[9]){
                        let index = 9
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[10] == false ? tileBack : tiles[10]){
                        let index = 10
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[11] == false ? tileBack : tiles[11]){
                        let index = 11
                        buttonTapped(index: index)
                        }
                }
                HStack{
                    Button(emojiShowing[12] == false ? tileBack : tiles[12]){
                        let index = 12
                        buttonTapped(index: index)
                        }
                    
                    Button(emojiShowing[13] == false ? tileBack : tiles[13]){
                        let index = 13
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[14] == false ? tileBack : tiles[14]){
                        let index = 14
                        buttonTapped(index: index)
                        }
                    Button(emojiShowing[15] == false ? tileBack : tiles[15]){
                        let index = 15
                        buttonTapped(index: index)
                        }
                }
            }
            .font(.largeTitle)
            .buttonStyle(.borderedProminent) //Unsicher
            .tint(.white) //Unsicher
            .controlSize(.large)
            .disabled(disableButtons)
            Text(gameMessage)
                .font(.largeTitle)
                .frame(height: 80)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            if guesses.count == 2 {
                if emojiShowing.contains(false) {
                    Button("Another Try?") {
                        disableButtons = false
                        if tiles[guesses[0]] != tiles[guesses[1]] {
                            emojiShowing[guesses[0]] = false
                            emojiShowing[guesses[1]] = false
                        }
                        guesses.removeAll()
                        gameMessage = ""
                    }
                    .buttonStyle(.glassProminent)
                    .font(.title)
                    .tint(tiles[guesses[0]] == tiles[guesses[1]] ? .mint : .red)
                    .frame(height: 80)
                    
                } else {
                    Button("Play Again?") {
                        disableButtons = false
                        guesses.removeAll()
                        gameMessage = ""
                        emojiShowing = Array(repeating: false, count: 16)
                        totalGuesses = 0
                        tiles.shuffle()
                    }
                    .buttonStyle(.glassProminent)
                    .font(.title)
                    .tint(.orange)
                    .frame(height: 80)
                }
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(height: 80)
            }
               
        }
        .padding()
        .onAppear {
            tiles = tiles + tiles
            tiles.shuffle()
            print(tiles)
        }
    }
    func checkForMatch() {
        if emojiShowing.contains(false) {
            if tiles[guesses[0]] == tiles[guesses[1]] {
                gameMessage = "✅ You Found a Match!"
                playSound(soundName: "correct")
            } else {
                gameMessage = "❌ Not a Match. Try Again."
                playSound(soundName: "wrong")
            }
        } else {
            gameMessage = "You guessed them all!"
            playSound(soundName: "ta-da")
        }
    }
    
    func buttonTapped(index: Int) {
        playSound(soundName: "tile-flip")
        if !emojiShowing[index] {
            emojiShowing[index] = true
            totalGuesses += 1
            guesses.append(index)
            print("guesses: \(guesses)")
            print("emojisShowing: \(emojiShowing)")
            if guesses.count == 2 {
                checkForMatch()
                disableButtons = true
            }
        }
    }
    
    func playSound(soundName: String) {
        
        // Stoppe aktuellen Sound falls einer läuft
        if let player = audioPlayer, player.isPlaying {
            player.stop()
        }
        
        // Lade Datei aus Assets
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview {
    ContentView()
}
