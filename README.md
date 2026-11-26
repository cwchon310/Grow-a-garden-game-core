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

## 圖片

目前倉庫內**沒有圖片文件**。若你有遊戲截圖、宣傳圖或圖標，歡迎加入 `assets/` 或 `docs/` 資料夾後一併提交。

## License

見 `LICENSE`。
