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
    
    loadStations()
    
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
    
    func loadStations(){
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
            Station(category: "1호선", name: "송내")]
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
