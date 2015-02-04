import Quick
import Nimble

class SLElseTableViewCellTest: QuickSpec {
    override func spec() {
        describe("type") {
            it("is SLElse") {
                let cell = SLElseTableViewCell(style: .Default, reuseIdentifier: nil)
                expect(cell.type) == BlockType.SLElse
            }
        }
    }
}



