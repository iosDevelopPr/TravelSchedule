
import SwiftUI
import Combine

struct StoryView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var stories: StoriesViewModel
    
    @State private var progress: CGFloat = 0
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    private let configuration: TimerConfiguration
    private let numberOfSections: Int = 3
    
    @State private var currentIndex: Int = 0
    
    private var descriptionStory: some View {
        VStack {
            Spacer()
            HStack {
                Text(stories.getTitle())
                    .font(.bold34)
                    .lineLimit(2)
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 12)
            
            HStack {
                Text(stories.getDescription())
                    .font(.regular20)
                    .lineLimit(3)
                Spacer()
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 57)
        }
    }

    init() {
        self.configuration = TimerConfiguration(storiesCount: numberOfSections)
        self.timer = Self.createTimer(configuration: configuration)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            stories.getBigImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 40))
            
            ProgressBar(numberOfSections: numberOfSections, progress: progress)
                .padding(.init(top: 34, leading: 12, bottom: 12, trailing: 12))
            
            descriptionStory

            CloseButtonView {
                dismiss()
            }
        }
        .preferredColorScheme(.dark)
        .gesture(
            DragGesture(
                minimumDistance: 50, coordinateSpace: .local
            )
            .onEnded { value in
                swipeHandler(value: value)
            }
        )
        .onAppear() {
            timer = Self.createTimer(configuration: configuration)
            cancellable = timer.connect()
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()
            incrementIndex()
        }
        .onTapGesture {
            stories.incrementIndex()
            progress = 0
            currentIndex = 0
        }
    }

    private func swipeHandler(value: DragGesture.Value) {
        let horizontalAmount = value.translation.width
        let verticalAmount = value.translation.height
        
        // Свайп вниз
        if abs(horizontalAmount) < abs(verticalAmount) {
            if verticalAmount > 0 {
                dismiss()
            }
        }
        
        else if abs(horizontalAmount) > abs(verticalAmount) {
            // Свайп вправо
            if horizontalAmount > 0 {
                stories.decrementIndex()
            }
            // Свайп влево
            else {
                stories.incrementIndex()
            }
            progress = 0
            currentIndex = 0
        }
    }
    
    private func timerTick() {
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            currentIndex = 0
            
            stories.incrementIndex()
        }
        progress = nextProgress
    }
    
    private func incrementIndex() {
        if currentIndex + 1 <= Int(progress * CGFloat(numberOfSections)) {
            currentIndex += 1
            stories.incrementIndex()
        }
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
        
}

#Preview {
    StoryView()
}
