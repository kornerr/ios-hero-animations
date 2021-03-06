
import UIKit

private func PINTEREST_SECTIONS_VIEW_LOG(_ message: String)
{
    NSLog("PinterestSectionsView \(message)")
}

class PinterestSectionsView:
    UIView,
    UICollectionViewDataSource
{

    // MARK: - SETUP

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupCollectionView()
    }

    // MARK: - ITEMS

    var items: [SectionsItem]
    {
        get
        {
            return _items
        }
        set
        {
            _items = newValue
            self.updateItems()
        }
    }
    private var _items = [SectionsItem]()

    private func updateItems()
    {
        // Provide item sizes to layout.
        let defaultSize = CGSize(width: 100, height: 100)
        let sizes = self.items.map { $0.image?.size ?? defaultSize }
        self.layout.itemSizes = sizes
        // Display items.
        self.collectionView.reloadData()
    }

    // MARK: - COLLECTION VIEW

    @IBOutlet private var collectionView: UICollectionView!
    private var layout: PinterestLayout!

    private func setupCollectionView()
    {
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: CellId)
        self.collectionView.dataSource = self

        self.layout = PinterestLayout()
        self.collectionView.collectionViewLayout = self.layout
        //self.collectionView.delegate = self
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return self.cell(forItemAt: indexPath)
    }

    /*
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CellView.size()
    }
    */

    // MARK: - CELL

    private let CellId = "CollectionViewCellId"
    private typealias CellView = PinterestSectionsItemView
    private typealias Cell = UICollectionViewCellTemplate<CellView>

    private func cell(forItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =
            self.collectionView.dequeueReusableCell(
                withReuseIdentifier: CellId,
                for: indexPath
            )
            as! Cell
        let item = self.items[indexPath.row]
        cell.itemView.image = item.image
        return cell
    }

}

