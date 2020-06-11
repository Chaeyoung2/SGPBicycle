/*
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Properties
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  
  var detailViewController: DetailViewController? = nil
  var stations = [Station]()
  var filteredStations = [Station]()
  let searchController = UISearchController(searchResultsController: nil)
    
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Stations"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = ["All", "1호선", "2호선", "3호선", "4호선", "5호선"]
    searchController.searchBar.delegate = self
    
    // Setup the search footer
    tableView.tableFooterView = searchFooter
    
    LoadStations()
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    //if splitViewController!.isCollapsed {
      if let selectionIndexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: selectionIndexPath, animated: animated)
      }
    //}
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
    
  
  // MARK: - Table View
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if isFiltering() {
         searchFooter.setIsFilteringToShow(filteredItemCount: filteredStations.count, of: stations.count)
         return filteredStations.count
       }
       
       searchFooter.setNotFiltering()
       return stations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let station: Station
    if isFiltering() {
      station = filteredStations[indexPath.row]
    } else {
      station = stations[indexPath.row]
    }
    cell.textLabel!.text = station.name
    cell.detailTextLabel!.text = station.category
    
    
    return cell
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print(segue.identifier)
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let station: Station
        if isFiltering() {
          station = filteredStations[indexPath.row]

        } else {
          station = stations[indexPath.row]
           
        }
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailStation = station
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        FindName = station.name
        
        print(FindName)
      }
    }
    
    
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
      filteredStations = stations.filter({( station : Station) -> Bool in
        let doesCategoryMatch = (scope == "All") || (station.category == scope)
        
        if searchBarIsEmpty() {
          return doesCategoryMatch
        } else {
          return doesCategoryMatch && station.name.lowercased().contains(searchText.lowercased())
        }
      })
      tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func LoadStations(){
        stations = [
            Station(category: "1호선", name: "소요산"),
            Station(category: "1호선", name: "동두천"),
            Station(category: "1호선", name: "보산"),
            Station(category: "1호선", name: "동두천중앙"),
            Station(category: "1호선", name: "지행"),
            Station(category: "1호선", name: "덕정"),
            Station(category: "1호선", name: "덕계"),
            Station(category: "1호선", name: "양주"),
            Station(category: "1호선", name: "녹양"),
            Station(category: "1호선", name: "가능"),
            Station(category: "1호선", name: "의정부"),
            Station(category: "1호선", name: "회룡"),
            Station(category: "1호선", name: "망월사"),
            Station(category: "1호선", name: "도봉산"),
            Station(category: "1호선", name: "도봉"),
            Station(category: "1호선", name: "방학"),
            Station(category: "1호선", name: "창동"),
            Station(category: "1호선", name: "녹천"),
            Station(category: "1호선", name: "월계"),
            Station(category: "1호선", name: "광운대"),
            Station(category: "1호선", name: "석계"),
            Station(category: "1호선", name: "신이문"),
            Station(category: "1호선", name: "외대앞"),
            Station(category: "1호선", name: "회기"),
            Station(category: "1호선", name: "청량리"),
            Station(category: "1호선", name: "제기동"),
            Station(category: "1호선", name: "신설동"),
            Station(category: "1호선", name: "동묘앞"),
            Station(category: "1호선", name: "동대문"),
            Station(category: "1호선", name: "종로5가"),
            Station(category: "1호선", name: "종로3가"),
            Station(category: "1호선", name: "종각"),
            Station(category: "1호선", name: "시청"),
            Station(category: "1호선", name: "서울역"),
            Station(category: "1호선", name: "남영"),
            Station(category: "1호선", name: "용산"),
            Station(category: "1호선", name: "노량진"),
            Station(category: "1호선", name: "대방"),
            Station(category: "1호선", name: "신길"),
            Station(category: "1호선", name: "영등포"),
            Station(category: "1호선", name: "신도림"),
            Station(category: "1호선", name: "구로"),
            
            Station(category: "1호선", name: "가산디지털단지"),
            Station(category: "1호선", name: "독산"),
            Station(category: "1호선", name: "금천구청"),
            Station(category: "1호선", name: "석수"),
            Station(category: "1호선", name: "관악"),
            Station(category: "1호선", name: "안양"),
            Station(category: "1호선", name: "명학"),
            Station(category: "1호선", name: "금정"),
            Station(category: "1호선", name: "군포"),
            Station(category: "1호선", name: "당정"),
            Station(category: "1호선", name: "의왕"),
            Station(category: "1호선", name: "성균관대"),
            Station(category: "1호선", name: "화서"),
            Station(category: "1호선", name: "수원"),
            Station(category: "1호선", name: "세류"),
            Station(category: "1호선", name: "병점"),
            Station(category: "1호선", name: "세마"),
            Station(category: "1호선", name: "오산대"),
            Station(category: "1호선", name: "오산"),
            Station(category: "1호선", name: "송탄"),
            Station(category: "1호선", name: "서정리"),
            Station(category: "1호선", name: "지제"),
            Station(category: "1호선", name: "평택"),
            
            Station(category: "1호선", name: "구일"),
            Station(category: "1호선", name: "개봉"),
            Station(category: "1호선", name: "오류동"),
            Station(category: "1호선", name: "온수"),
            Station(category: "1호선", name: "역곡"),
            Station(category: "1호선", name: "소사"),
            Station(category: "1호선", name: "부천"),
            Station(category: "1호선", name: "중동"),
            Station(category: "1호선", name: "송내"),
                Station(category:"2호선" , name:"신도림" ),
                Station(category:"2호선" , name:"대림" ),
                Station(category:"2호선" , name:"구로디지털단지"),
                Station(category:"2호선" , name:"신대방" ),
                Station(category:"2호선" , name:"신림" ),
                Station(category:"2호선" , name:"봉천" ),
                Station(category:"2호선" , name:"서울대입구" ),
                Station(category:"2호선" , name:"낙성대" ),
                Station(category:"2호선" , name:"사당" ),
                Station(category:"2호선" , name:"방배" ),
                Station(category:"2호선" , name:"서초" ),
                Station(category:"2호선" , name:"교대" ),
                Station(category:"2호선" , name:"강남" ),
                Station(category:"2호선" , name:"서초" ),
                Station(category:"2호선" , name:"역삼" ),
                Station(category:"2호선" , name:"삼성" ),
                Station(category:"2호선" , name:"선릉" ),
                Station(category:"2호선" , name:"종합운동장" ),
                Station(category:"2호선" , name:"신천" ),
                Station(category:"2호선" , name:"잠실" ),
                Station(category:"2호선" , name:"잠실나루" ),
                Station(category:"2호선" , name:"강변" ),
                Station(category:"2호선" , name:"구의" ),
                Station(category:"2호선" , name:"건대입구" ),
                Station(category:"2호선" , name:"성수" ),
                Station(category:"2호선" , name:"뚝섬" ),
                Station(category:"2호선" , name:"한양대" ),
                Station(category:"2호선" , name:"왕십리" ),
                Station(category:"2호선" , name:"상왕십리" ),
                Station(category:"2호선" , name:"신당" ),
                Station(category:"2호선" , name:"동대문역사문화공원" ),
                Station(category:"2호선" , name:"을지로4가" ),
                Station(category:"2호선" , name:"을지로3가" ),
                Station(category:"2호선" , name:"을지로입구" ),
                Station(category:"2호선" , name:"시청" ),
                Station(category:"2호선" , name:"충정로" ),
                Station(category:"2호선" , name:"아현" ),
                Station(category:"2호선" , name:"이대" ),
                Station(category:"2호선" , name:"신촌" ),
                Station(category:"2호선" , name:"홍대입구" ),
                Station(category:"2호선" , name:"합정" ),
                Station(category:"2호선" , name:"당산" ),
                Station(category:"2호선" , name:"영등포구청" ),
                Station(category:"2호선" , name:"문래" ),
                Station(category:"2호선" , name:"까치산" ),
                Station(category:"2호선" , name:"신정네거리" ),
                Station(category:"2호선" , name:"양천구청" ),
                Station(category:"2호선" , name:"도림천" ),
                Station(category:"2호선" , name:"신설동" ),
                Station(category:"2호선" , name:"용두" ),
                Station(category:"2호선" , name:"신답" ),
                Station(category:"2호선" , name:"용답" ),
            
            Station(category:"3호선" , name:"대화" ),
            Station(category:"3호선" , name:"주엽" ),
            Station(category:"3호선" , name:"정발산" ),
            Station(category:"3호선" , name:"마두" ),
            Station(category:"3호선" , name:"백석" ),
            Station(category:"3호선" , name:"대곡" ),
            Station(category:"3호선" , name:"화정" ),
            Station(category:"3호선" , name:"원당" ),
            Station(category:"3호선" , name:"원흥" ),
            Station(category:"3호선" , name:"삼송" ),
            Station(category:"3호선" , name:"지축" ),
            Station(category:"3호선" , name:"구파발" ),
            Station(category:"3호선" , name:"연신내" ),
            Station(category:"3호선" , name:"불광" ),
            Station(category:"3호선" , name:"녹번" ),
            Station(category:"3호선" , name:"홍제" ),
            Station(category:"3호선" , name:"무악제" ),
            Station(category:"3호선" , name:"독립문" ),
            Station(category:"3호선" , name:"경복궁" ),
            Station(category:"3호선" , name:"안국" ),
            Station(category:"3호선" , name:"종로3가" ),
            Station(category:"3호선" , name:"을지로3가" ),
            Station(category:"3호선" , name:"충무로" ),
            Station(category:"3호선" , name:"동대입구" ),
            Station(category:"3호선" , name:"약수" ),
            Station(category:"3호선" , name:"금호" ),
            Station(category:"3호선" , name:"옥수" ),
            Station(category:"3호선" , name:"압구정" ),
            Station(category:"3호선" , name:"신사" ),
            Station(category:"3호선" , name:"잠원" ),
            Station(category:"3호선" , name:"고속터미널" ),
            Station(category:"3호선" , name:"교대" ),
            Station(category:"3호선" , name:"남부터미널" ),
            Station(category:"3호선" , name:"양재" ),
            Station(category:"3호선" , name:"매봉" ),
            Station(category:"3호선" , name:"도곡" ),
            Station(category:"3호선" , name:"대치" ),
            Station(category:"3호선" , name:"학여울" ),
            Station(category:"3호선" , name:"대청" ),
            Station(category:"3호선" , name:"일원" ),
            Station(category:"3호선" , name:"수서" ),
            Station(category:"3호선" , name:"가락시장" ),
            Station(category:"3호선" , name:"경찰병원" ),
            Station(category:"3호선" , name:"오금" ),
            Station(category:"4호선" , name:"당고개" ),
            Station(category:"4호선" , name:"상계" ),
            Station(category:"4호선" , name:"노원" ),
            Station(category:"4호선" , name:"창동" ),
            Station(category:"4호선" , name:"쌍문" ),
            Station(category:"4호선" , name:"수유" ),
            Station(category:"4호선" , name:"미아" ),
            Station(category:"4호선" , name:"미아사거리" ),
            Station(category:"4호선" , name:"길음" ),
            Station(category:"4호선" , name:"성신여대입구" ),
            Station(category:"4호선" , name:"한성대입구" ),
            Station(category:"4호선" , name:"혜화" ),
            Station(category:"4호선" , name:"동대문" ),
            Station(category:"4호선" , name:"동대문역사문화공원" ),
            Station(category:"4호선" , name:"충무로" ),
            Station(category:"4호선" , name:"명동" ),
            Station(category:"4호선" , name:"회현" ),
            Station(category:"4호선" , name:"서울역" ),
            Station(category:"4호선" , name:"숙대입구" ),
            Station(category:"4호선" , name:"삼각지" ),
            Station(category:"4호선" , name:"신용산" ),
            Station(category:"4호선" , name:"이촌" ),
            Station(category:"4호선" , name:"동작" ),
            Station(category:"4호선" , name:"총신대입구" ),
            Station(category:"4호선" , name:"사당" ),
            Station(category:"4호선" , name:"남태령" ),
            Station(category:"4호선" , name:"선바위" ),
            Station(category:"4호선" , name:"경마공원" ),
            Station(category:"4호선" , name:"대공원" ),
            Station(category:"4호선" , name:"과천" ),
            Station(category:"4호선" , name:"정부과천청사" ),
            Station(category:"4호선" , name:"인덕원" ),
            Station(category:"4호선" , name:"평촌" ),
            Station(category:"4호선" , name:"범계" ),
            Station(category:"4호선" , name:"금정" ),
            Station(category:"4호선" , name:"산본" ),
            Station(category:"4호선" , name:"수리산" ),
            Station(category:"4호선" , name:"대야미" ),
            Station(category:"4호선" , name:"반월" ),
            Station(category:"4호선" , name:"상록수" ),
            Station(category:"4호선" , name:"한대앞" ),
            Station(category:"4호선" , name:"중앙" ),
            Station(category:"4호선" , name:"고잔" ),
            Station(category:"4호선" , name:"초지" ),
            Station(category:"4호선" , name:"안산" ),
            Station(category:"4호선" , name:"신길온천" ),
            Station(category:"4호선" , name:"정왕" ),
            Station(category:"4호선" , name:"오이도" ),




            ]
              

    }
    
    }

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
