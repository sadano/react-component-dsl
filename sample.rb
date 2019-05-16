url ["purchase", "item"]

container "PurchaseItemPage" do
    child "PageTitle"
    child "ItemInfo"
    child "PurchaseButton" 
end

component "ItemInfo" do
    child "ItemIcon"
    child "ItemType"
    child "ItemName"
    child "ItemDetailLink"
end