//
//  StocksView.swift
//  Stocks App HW9 CSCI571
//
//  Created by Narasimha Rao Gundavarapu on 11/17/20.
//

import SwiftUI


struct StocksView: View {
    
//    @ObservedObject var favoriteStockList = Favorites.shared;
//    @ObservedObject var portfolio = Portfolio.shared;
//    @ObservedObject var stockPriceManager = StockPriceManager.shared;
    @ObservedObject var stocksVM = StockViewModel()
    
    @ObservedObject var searchBar = SearchBar();
    @ObservedObject var searchResult = SearchResult()
    let results = [ SearchResultItem(id:"AAPL", sName: "Apple Inc"),
                    SearchResultItem(id: "SNAP", sName: "Apple Inc"),
                    SearchResultItem(id: "AAPL", sName: "Apple Inc"),
                    SearchResultItem(id: "AAPL", sName: "Apple Inc")]
    
    @State var isSearchClicked = false
    
    @State private var isEditable = false;
    @State private var sort: Int = 0;
    
    let formatter = DateFormatter();
    private var dateString = "";
    
    init() {
        sleep(2)
        formatter.dateStyle = .long;
        self.dateString = formatter.string(from: Date());
    }
    
    var body: some View {
        
        if(searchBar.text.count > 0){
            NavigationView{
                List(searchResult.results.filter {
                    searchBar.text.isEmpty ||
                        $0.id.localizedStandardContains(searchBar.text)
                }) {_ in
                    NavigationLink(
                        destination: StockDetailsView()){}
                }.add(self.searchBar)
            }
        }
        else{
        NavigationView {
            

            List {
                Text(dateString).fontWeight(.bold).foregroundColor(.secondary).font(.title)
                Section(header: Text("Portfolio")) {
                    VStack(alignment: .leading){
                    Text("Net Worth").font(.title)
                    Text("20000.00").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    ForEach(self.stocksVM.cData) {stock in
                        
                        NavigationLink(
                            destination: StockDetailsView()){
                        VStack(alignment: .leading){
                            HStack{
                                Text(stock.ticker).bold()
                                Spacer()
                                Text(stock.stockName).bold()
                            }
                            HStack{
                                Text("\(stock.quantity) Shares").foregroundColor(.secondary)
                                Spacer()
                                Label("\(stock.change)", systemImage: "arrow.down.right").foregroundColor(.red)
                            }
                        }
                        }
                    }.onDelete(perform: {stock in self.stocksVM.cData})
                }
                Section(header: Text("Favorites")) {
                    ForEach(0..<3) {_ in
                        
                        NavigationLink(
                            destination: StockDetailsView()){
                        VStack(alignment: .leading){
                            HStack{
                                Text("SNAP").bold()
                                Spacer()
                                Text("111.20").bold()
                            }
                            HStack{
                                Text("11.00 Shares").foregroundColor(.secondary)
                                Spacer()
                                Label("-5.40", systemImage: "arrow.down.right").foregroundColor(.red)
                            }
                        }
                        }
                    }.onDelete(perform: {_ in })
                }
                
                HStack{
                    Spacer()
                    Link("Powered by Tiingo", destination: URL(string: "https://www.tiingo.com")!).foregroundColor(.secondary).font(.footnote)
                    Spacer()
                }
            }
                .navigationBarTitle("Stocks")
            .toolbar {
                        ToolbarItem() {
                            Button("Edit") {
                                print("Pressed")
                            }
                        }
                    }
            //toolbar item
            .add(self.searchBar)
            
            
        }
        }
        

        
        
    
    
}

}




struct StocksView_Previews: PreviewProvider {
    static var previews: some View {
        StocksView()
    }
}
