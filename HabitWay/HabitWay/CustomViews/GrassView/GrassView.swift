//
//  GrassView.swift
//  HabitWay
//
//  Created by Burak Yılmaz on 21.11.2023.
//

import SwiftUI

public struct GrassView: View {
    private let data: [String: Int]
    
    private let row: Int
    private let col: Int
    private let cellColor: Color
    private let cellSpacing: CGFloat
    
    private let onCellTouch: (String, Int) -> Void
    
    private let formatString: String
    private let formatter = DateFormatter()
    private let date = Date()
    private let calendar = Calendar.current
    
    @StateObject var viewModel = GrassViewModel()
    
    public init (
        _ data:[String: Int] = [:],
        row: Int = 5, col: Int = 15,
        cellColor: Color = .gray,
        cellSpacing: CGFloat = 2,
        formatString: String = "yyyy-MM-dd",
        locale: Locale = Locale(identifier: Locale.current.identifier),
        timeZone: TimeZone? = TimeZone(identifier: TimeZone.current.identifier),
        onCellTouch: @escaping (String, Int) -> Void = { _, _ in }
    ) {
        self.data = data
        self.row = row
        self.col = col
        self.cellColor = cellColor
        self.cellSpacing = cellSpacing
        self.formatString = formatString
        self.formatter.dateFormat = formatString
        self.formatter.timeZone = timeZone
        self.formatter.locale = locale
        self.onCellTouch = onCellTouch
    }
    
    public var body: some View {
        let rowItems = (0..<row)
        GeometryReader(content: { geometry in
            ScrollViewReader { scrollProxy in
                ScrollView (.horizontal, showsIndicators: false) {
                    VStack(spacing: cellSpacing) {
                        ForEach(0..<row, id: \.self) { row in
                            HStack(spacing: cellSpacing) {
                                ForEach(0..<col, id: \.self) { col in
                                    GrassViewCell(
                                        date: getDate(rowcol: [row, col]),
                                        level: getLevel(rowcol: [row, col]),
                                        cellColor: .yellow,
                                        onCellTouch: self.onCellTouch,
                                        row: row,
                                        col: col
                                    )
                                    .environmentObject(viewModel)
                                    .onAppear(perform: {
                                        scrollProxy.scrollTo(rowItems.last!, anchor: .trailing)
                                    })
                                }
                            }
                        }
                    }
                }
                
            }
            .coordinateSpace(name: "container")
            .gesture(
                LongPressGesture().sequenced(before: DragGesture(coordinateSpace: .named("container"))
                    .onChanged{ touched in
                        viewModel.touchLocation = touched.location
                    }
                    .onEnded{ _ in
                        viewModel.touchLocation = nil
                    })
            )
        })
    }
    
    func getDate(rowcol:[Int]) -> String {
        let asda =  (7 - date.dayNumberOfWeek()! + calendar.firstWeekday - 1) % 7
        let diff = -1 * ( (row - rowcol[0] - 1) + (col - rowcol[1] - 1) * row ) + asda
        let date = calendar.date(byAdding: .day, value: diff, to: self.date) ?? self.date
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func getLevel(rowcol: [Int]) -> Int {
        return self.data[getDate(rowcol: rowcol)] ?? 0
    }
}

struct GrassView_Previews: PreviewProvider {
    static var previews: some View {
        GrassView([:])
    }
}

extension GrassView {
    class GrassViewModel: ObservableObject {
        @Published var touchLocation: CGPoint? = nil
        @Published var isPortrait: Bool = true
    }
}

extension GrassView {
    public func spacing() -> some View {
        modifier(CellSpacing())
    }
}

struct CellSpacing: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}

extension GrassView {
    func radius() -> some View {
        modifier(CellRadius())
    }
}

struct CellRadius: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}
