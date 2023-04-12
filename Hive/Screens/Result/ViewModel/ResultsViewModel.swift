//
//  ResultsViewModel.swift
//  Hive
//
//  Created by Vipul Negi on 10/04/23.
//

import Foundation

class ResultsViewModel: NSObject {
    
    var reloadTableView: (() -> Void)?
    var results = Pages()
    
    var resultCellViewModels = [ResultCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    private var resultService: ResultsServiceProtocol
    
    
    init(resultService: ResultsServiceProtocol = ResultsService()) {
        self.resultService = resultService
    }
    
    func getResults(str: String) {
        resultService.getResults(searchStr: str) { success, model, error in
            if success, let results = model {
                if results.query != nil {
                    let page = results.query?.pages!.values.sorted { $0.title! < $1.title! }
                    self.fetchData(results: page!)
                }
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(results: Pages) {
        self.results = results // Cache
        var vms = [ResultCellViewModel]()
        for result in results {
            vms.append(createCellModel(result: result))
        }
        resultCellViewModels = vms
    }

    func createCellModel(result: Page) -> ResultCellViewModel {
        let id = result.pageid ?? 0
        let title = result.title ?? ""
        let subTitle = result.extract ?? ""
        let imageUrl = result.thumbnail?.source ?? ""
        let width = result.thumbnail?.width ?? 0.0
        let height = result.thumbnail?.height ?? 0.0

        return ResultCellViewModel(id: id, title: title, subTitle: subTitle, imageUrl: imageUrl, width: width, height: height)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ResultCellViewModel {
        return resultCellViewModels[indexPath.row]
    }
}
