# Grow a Garden Game Core

Roblox 園林遊戲核心模組，包含種植、寵物、天氣、貨幣、任務等系統。

## 倉庫結構

| 路徑 | 說明 |
|------|------|
| `ReplicatedStorage/` | 客戶端與伺服器共用模組（資料、物品、植物、遠端事件、寵物註冊表等） |
| `ServerScriptService/` | 伺服器服務（資料儲存、天氣、寵物、貨幣、任務、背包等） |
| `ServerStorage/` | 伺服器端儲存（目前為空，需自行放入 PlantHandler、Collectables、PlayerData 等） |
| `Grow a Garden UNCOPYLOCKED.rbxl` | Roblox Studio 地方檔（3.2 MB） |
| `README BEFORE LAUNCH!!.txt` | 啟動前注意事項（合作夥伴提供） |

## 已知缺失（非完整可直接運行的遊戲）

此倉庫為模組集合，**不是可直接運行的完整遊戲**。程式碼引用了以下不存在於倉庫中的依賴：

- `ReplicatedStorage.Modules.GetFarm`
- `ReplicatedStorage.Modules.StringUtils`
- `ReplicatedStorage.Modules.PlayerLuck`
- `ReplicatedStorage.GameEvents`
- `ServerStorage.PlantHandler`
- `ServerStorage.Collectables`
- `ServerStorage.PlayerData`

使用前請在 Roblox Studio 中補齊上述依賴，或在 `.rbxl` 地方檔中確認這些物件已存在。

## 圖片預覽

![遊戲圖標](assets/905bd722ee0a6ceda3caacde54c0b081.png)
![遊戲截圖](assets/db3312a56f2d4b12e4a5e55523e6320c.png)
![遊戲縮圖](assets/d8ff6ab6cc7b632e0377bdb206f69490.png)
![宣傳圖](assets/fc3f3e3158fc20ebb5ccc972064ebfe6.png)

> 圖片來自 Roblox 官方搜尋頁面，僅供參考。若你有自製截圖，歡迎替換 `assets/` 資料夾內的文件。

## License

見 `LICENSE`。
