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
    
    
    let indexPath = tableView.indexPathForSelectedRow
    
    if !isFiltering(){
        FindName = stations[indexPath!.row].name
        FindCode = stations[indexPath!.row].returnCode()
        if stations[indexPath!.row].category == "1호선"{
            clb = 0
            FindLine = "1"
        } else if stations[indexPath!.row].category == "2호선"{
            clb = 1
            FindLine = "2"
        } else if stations[indexPath!.row].category == "3호선"{
            clb = 2
            FindLine = "3"
        } else if stations[indexPath!.row].category == "4호선"{
            clb = 3
            FindLine = "4"
        } else if stations[indexPath!.row].category == "5호선"{
            clb = 4
            FindLine = "5"
        }
    }
    else{
        //print(indexPath!.row)
        FindName = filteredStations[indexPath!.row].name
        FindCode = stations[indexPath!.row].returnCode()
        if filteredStations[indexPath!.row].category == "1호선"{
            clb = 0
            FindLine = "1"
        } else if filteredStations[indexPath!.row].category == "2호선"{
            clb = 1
            FindLine = "2"
        } else if filteredStations[indexPath!.row].category == "3호선"{
            clb = 2
            FindLine = "3"
        } else if filteredStations[indexPath!.row].category == "4호선"{
            clb = 3
            FindLine = "4"
        } else if filteredStations[indexPath!.row].category == "5호선"{
            clb = 4
            FindLine = "5"
        }
    }
    
    
//    print("clb : " + String(clb))
//    print("FindName : " + String(FindName))
//    print("FindCode : " + String(FindCode))
//    print("FindLine : " + String(FindLine))


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
   Station(category: "1호선", name: "소요산", code: "1916"),
    Station(category: "1호선", name: "동두천", code: "1915"),
    Station(category: "1호선", name: "보산", code: "1914"),
    Station(category: "1호선", name: "동두천중앙", code: "1913"),
    Station(category: "1호선", name: "지행", code: "1912"),
    Station(category: "1호선", name: "덕정", code: "1911"),
    Station(category: "1호선", name: "덕계", code: "1910"),
    Station(category: "1호선", name: "양주", code: "1909"),
    Station(category: "1호선", name: "녹양", code: "1908"),
    Station(category: "1호선", name: "가능", code: "1907"),
    Station(category: "1호선", name: "의정부", code: "1906"),
    Station(category: "1호선", name: "회룡", code: "1905"),
    Station(category: "1호선", name: "망월사", code: "1904"),
    Station(category: "1호선", name: "도봉산", code: "1903"),
    Station(category: "1호선", name: "도봉", code: "1902"),
    Station(category: "1호선", name: "방학", code: "1901"),
    Station(category: "1호선", name: "창동", code: "1022"),
    Station(category: "1호선", name: "녹천", code: "1021"),
    Station(category: "1호선", name: "월계", code: "1020"),
    Station(category: "1호선", name: "광운대", code: "1019"),
    Station(category: "1호선", name: "석계", code: "1018"),
    Station(category: "1호선", name: "신이문", code: "1017"),
    Station(category: "1호선", name: "외대앞", code: "1016"),
    Station(category: "1호선", name: "회기", code: "1015"),
    Station(category: "1호선", name: "청량리", code: "0158"),
    Station(category: "1호선", name: "제기동", code: "0157"),
    Station(category: "1호선", name: "신설동", code: "0156"),
    Station(category: "1호선", name: "동묘앞", code: "0159"),
    Station(category: "1호선", name: "동대문", code: "0155"),
    Station(category: "1호선", name: "종로5가", code: "0154"),
    Station(category: "1호선", name: "종로3가", code: "0153"),
    Station(category: "1호선", name: "종각", code: "0152"),
    Station(category: "1호선", name: "시청", code: "0151"),
    Station(category: "1호선", name: "서울역", code: "0150"),
    Station(category: "1호선", name: "남영", code: "1002"),
    Station(category: "1호선", name: "용산", code: "1003"),
    Station(category: "1호선", name: "노량진", code: "1004"),
    Station(category: "1호선", name: "대방", code: "1005"),
    Station(category: "1호선", name: "신길", code: "1032"),
    Station(category: "1호선", name: "영등포", code: "1006"),
    Station(category: "1호선", name: "신도림", code: "1007"),
    Station(category: "1호선", name: "구로", code: "1701"),
    
    Station(category: "1호선", name: "가산디지털단지", code: "1702"),
    Station(category: "1호선", name: "독산", code: "1714"),
    Station(category: "1호선", name: "금천구청", code: "1703"),
    Station(category: "1호선", name: "석수", code: "1705"),
    Station(category: "1호선", name: "관악", code: "1706"),
    Station(category: "1호선", name: "안양", code: "1707"),
    Station(category: "1호선", name: "명학", code: "1708"),
    Station(category: "1호선", name: "금정", code: "1709"),
    Station(category: "1호선", name: "군포", code: "1710"),
    Station(category: "1호선", name: "당정", code: "1711"),
    Station(category: "1호선", name: "의왕", code: "1712"),
    Station(category: "1호선", name: "성균관대", code: "1713"),
    Station(category: "1호선", name: "화서", code: "1714"),
    Station(category: "1호선", name: "수원", code: "1715"),
    Station(category: "1호선", name: "세류", code: "1716"),
    Station(category: "1호선", name: "병점", code: "1717"),
    Station(category: "1호선", name: "세마", code: "1718"),
    Station(category: "1호선", name: "오산대", code: "1719"),
    Station(category: "1호선", name: "오산", code: "1720"),
    Station(category: "1호선", name: "송탄", code: "1721"),
    Station(category: "1호선", name: "서정리", code: "1722"),
    Station(category: "1호선", name: "지제", code: "1723"),
    Station(category: "1호선", name: "평택", code: "1724"),
    
    Station(category: "1호선", name: "구일", code: "1813"),
    Station(category: "1호선", name: "개봉", code: "1801"),
    Station(category: "1호선", name: "오류동", code: "1802"),
    Station(category: "1호선", name: "온수", code: "1821"),
    Station(category: "1호선", name: "역곡", code: "1803"),
    Station(category: "1호선", name: "소사", code: "1814"),
    Station(category: "1호선", name: "부천", code: "1804"),
    Station(category: "1호선", name: "중동", code: "1822"),
    Station(category: "1호선", name: "송내", code: "1805"),
            
 Station(category:"2호선" , name:"신도림", code: "0234"),
                                Station(category:"2호선" , name:"대림", code: "0233" ),
                                Station(category:"2호선" , name:"구로디지털단지", code: "0232"),
                                Station(category:"2호선" , name:"신대방", code: "0231"),
                                Station(category:"2호선" , name:"신림" , code: "0230"),
                                Station(category:"2호선" , name:"봉천", code: "0229" ),
                                Station(category:"2호선" , name:"서울대입구" , code: "0228"),
                                Station(category:"2호선" , name:"낙성대", code: "0227"),
                                Station(category:"2호선" , name:"사당", code: "0226"),
                                Station(category:"2호선" , name:"방배", code: "0225"),
                                Station(category:"2호선" , name:"서초", code: "0224"),
                                Station(category:"2호선" , name:"교대", code: "0223"),
                                Station(category:"2호선" , name:"강남" , code: "0222"),
                                Station(category:"2호선" , name:"서초", code: "0224"),
                                Station(category:"2호선" , name:"역삼", code: "0221"),
                                Station(category:"2호선" , name:"삼성" , code: "0219"),
                                Station(category:"2호선" , name:"선릉" , code: "0220"),
                                Station(category:"2호선" , name:"종합운동장", code: "0218"),
                                //Station(category:"2호선" , name:"신천", code: "0234"),
                                Station(category:"2호선" , name:"잠실", code: "0216"),
                                Station(category:"2호선" , name:"잠실나루", code: "0215"),
                                Station(category:"2호선" , name:"강변", code: "0214"),
                                Station(category:"2호선" , name:"구의", code: "0213"),
                                Station(category:"2호선" , name:"건대입구", code: "0212"),
                                Station(category:"2호선" , name:"성수", code: "0211"),
                                Station(category:"2호선" , name:"뚝섬", code: "0210"),
                                Station(category:"2호선" , name:"한양대", code: "0209"),
                                Station(category:"2호선" , name:"왕십리", code: "0208"),
                                Station(category:"2호선" , name:"상왕십리", code: "0207"),
                                Station(category:"2호선" , name:"신당", code: "0206"),
                                Station(category:"2호선" , name:"동대문역사문화공원", code: "0205"),
                                Station(category:"2호선" , name:"을지로4가", code: "0204"),
                                Station(category:"2호선" , name:"을지로3가", code: "0203"),
                                Station(category:"2호선" , name:"을지로입구", code: "0202"),
                                Station(category:"2호선" , name:"시청", code: "0201"),
                                Station(category:"2호선" , name:"충정로", code: "0243"),
                                Station(category:"2호선" , name:"아현", code: "0242"),
                                Station(category:"2호선" , name:"이대", code: "0241"),
                                Station(category:"2호선" , name:"신촌", code: "0240"),
                                Station(category:"2호선" , name:"홍대입구", code: "0239"),
                                Station(category:"2호선" , name:"합정", code: "0238"),
                                Station(category:"2호선" , name:"당산", code: "0237"),
                                Station(category:"2호선" , name:"영등포구청", code: "0236"),
                                Station(category:"2호선" , name:"문래", code: "0235"),
                                Station(category:"2호선" , name:"까치산", code: "0260"),
                                Station(category:"2호선" , name:"신정네거리", code: "0249"),
                                Station(category:"2호선" , name:"양천구청", code: "0248"),
                                Station(category:"2호선" , name:"도림천", code: "0247"),
                        //        Station(category:"2호선" , name:"신설동" ),
                        //        Station(category:"2호선" , name:"용두" ),
                        //        Station(category:"2호선" , name:"신답" ),
                        //        Station(category:"2호선" , name:"용답" ),
                
               Station(category:"3호선" , name:"대화", code: "1958"),
                Station(category:"3호선" , name:"주엽", code: "1957" ),
                Station(category:"3호선" , name:"정발산", code: "1956" ),
                Station(category:"3호선" , name:"마두", code: "1955" ),
                Station(category:"3호선" , name:"백석", code: "1954" ),
                Station(category:"3호선" , name:"대곡", code: "1953" ),
                Station(category:"3호선" , name:"화정", code: "1952" ),
                Station(category:"3호선" , name:"원당", code: "1951" ),
                //Station(category:"3호선" , name:"원흥" ),
                Station(category:"3호선" , name:"삼송", code: "1950"),
                Station(category:"3호선" , name:"지축", code: "0309"),
                Station(category:"3호선" , name:"구파발", code: "0310" ),
                Station(category:"3호선" , name:"연신내", code: "0311"),
                Station(category:"3호선" , name:"불광", code: "0312" ),
                Station(category:"3호선" , name:"녹번" , code: "0313"),
                Station(category:"3호선" , name:"홍제", code: "0314" ),
                Station(category:"3호선" , name:"무악제", code: "0315"),
                Station(category:"3호선" , name:"독립문", code: "0316"),
                Station(category:"3호선" , name:"경복궁", code: "0317"),
                Station(category:"3호선" , name:"안국", code: "0318" ),
                Station(category:"3호선" , name:"종로3가" , code: "0319"),
                Station(category:"3호선" , name:"을지로3가" , code: "0320"),
                Station(category:"3호선" , name:"충무로", code: "0321"),
                Station(category:"3호선" , name:"동대입구" , code: "0322"),
                Station(category:"3호선" , name:"약수" , code: "0323"),
                Station(category:"3호선" , name:"금호" , code: "0324"),
                Station(category:"3호선" , name:"옥수" , code: "0325"),
                Station(category:"3호선" , name:"압구정" , code: "0326"),
                Station(category:"3호선" , name:"신사" , code: "0327"),
                Station(category:"3호선" , name:"잠원" , code: "0328"),
                Station(category:"3호선" , name:"고속터미널" , code: "0329"),
                Station(category:"3호선" , name:"교대", code: "0330" ),
                Station(category:"3호선" , name:"남부터미널", code: "0331" ),
                Station(category:"3호선" , name:"양재", code: "0332" ),
                Station(category:"3호선" , name:"매봉", code: "0333" ),
                Station(category:"3호선" , name:"도곡", code: "0334" ),
                Station(category:"3호선" , name:"대치", code: "0335" ),
                Station(category:"3호선" , name:"학여울", code: "0336" ),
                Station(category:"3호선" , name:"대청", code: "0337" ),
                Station(category:"3호선" , name:"일원", code: "0338" ),
                Station(category:"3호선" , name:"수서", code: "0339" ),
                Station(category:"3호선" , name:"가락시장", code: "0340"),
                Station(category:"3호선" , name:"경찰병원", code: "0341"),
                Station(category:"3호선" , name:"오금", code: "0342"),
            
               Station(category:"4호선" , name:"당고개", code: "0409"),
                Station(category:"4호선" , name:"상계", code: "0410"),
                Station(category:"4호선" , name:"노원", code: "0411"),
                Station(category:"4호선" , name:"창동", code: "0412"),
                Station(category:"4호선" , name:"쌍문", code: "0413"),
                Station(category:"4호선" , name:"수유", code: "0414"),
                Station(category:"4호선" , name:"미아", code: "0415"),
                Station(category:"4호선" , name:"미아사거리", code: "0416"),
                Station(category:"4호선" , name:"길음", code: "0417"),
                Station(category:"4호선" , name:"성신여대입구", code: "0418"),
                Station(category:"4호선" , name:"한성대입구", code: "0419"),
                Station(category:"4호선" , name:"혜화", code: "0420"),
                Station(category:"4호선" , name:"동대문", code: "0421"),
                Station(category:"4호선" , name:"동대문역사문화공원", code: "0422"),
                Station(category:"4호선" , name:"충무로", code: "0423"),
                Station(category:"4호선" , name:"명동", code: "0424"),
                Station(category:"4호선" , name:"회현", code: "0425"),
                Station(category:"4호선" , name:"서울역", code: "0426"),
                Station(category:"4호선" , name:"숙대입구", code: "0427"),
                Station(category:"4호선" , name:"삼각지", code: "0428"),
                Station(category:"4호선" , name:"신용산", code: "0429"),
                Station(category:"4호선" , name:"이촌", code: "0430"),
                Station(category:"4호선" , name:"동작", code: "0431"),
                Station(category:"4호선" , name:"총신대입구", code: "0432"),
                Station(category:"4호선" , name:"사당", code: "0433"),
                Station(category:"4호선" , name:"남태령" , code: "0434"),
                Station(category:"4호선" , name:"선바위" , code: "1450"),
                Station(category:"4호선" , name:"경마공원" , code: "1451"),
                Station(category:"4호선" , name:"대공원" , code: "1452"),
                Station(category:"4호선" , name:"과천" , code: "1453"),
                Station(category:"4호선" , name:"정부과천청사" , code: "1454"),
                Station(category:"4호선" , name:"인덕원" , code: "1455"),
                Station(category:"4호선" , name:"평촌" , code: "1456" ),
                Station(category:"4호선" , name:"범계" , code: "1457"),
                Station(category:"4호선" , name:"금정" , code: "1458"),
                Station(category:"4호선" , name:"산본" , code: "1751"),
                Station(category:"4호선" , name:"수리산", code: "1763"),
                Station(category:"4호선" , name:"대야미", code: "1752"),
                Station(category:"4호선" , name:"반월", code: "1753"),
                Station(category:"4호선" , name:"상록수", code: "1754"),
                Station(category:"4호선" , name:"한대앞", code: "1755"),
                Station(category:"4호선" , name:"중앙", code: "1756"),
                Station(category:"4호선" , name:"고잔", code: "1757"),
                Station(category:"4호선" , name:"초지", code: "1758"),
                Station(category:"4호선" , name:"안산" , code: "1759"),
                Station(category:"4호선" , name:"신길온천", code: "1760"),
                Station(category:"4호선" , name:"정왕", code: "1761"),
                Station(category:"4호선" , name:"오이도", code: "1762" ),






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
