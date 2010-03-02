class CreatePageSpeeds < ActiveRecord::Migration
  def self.up
    create_table :page_speeds, :primary_key => :id do |t|
      t.integer :id
      t.integer :ip
      t.text :user_agent
      t.integer :url_id
      t.integer :w
      t.float :o
      t.integer :l
      t.integer :r
      t.integer :t
      t.text :v
      t.float :pMinifyCSS
      t.float :pMinifyJS
      t.float :pOptImgs
      t.float :pImgDims
      t.float :pCombineJS
      t.float :pCombineCSS
      t.float :pCssInHead
      t.float :pBrowserCache
      t.float :pProxyCache
      t.float :pNoCookie
      t.float :pCookieSize
      t.float :pParallelDl
      t.float :pCssSelect
      t.float :pCssJsOrder
      t.float :pDeferJS
      t.float :pGzip
      t.float :pMinRedirect
      t.float :pCssExpr
      t.float :pUnusedCSS
      t.float :pScaleImgs
      t.float :pMinDns
      t.float :pAvoidBadRequests
      t.float :pDupeRsrc
      t.float :pOptimizeTheOrderOfStylesAndScripts
      t.float :pMinimizeRequestSize
      t.float :pSpecifyImageDimensions
      t.float :pPutCssInTheDocumentHead
      t.float :pMinifyHTML
      t.float :pServeScaledImages
      t.float :pSpecifyCharsetEarly
      
      t.timestamps
    end
    # add_index :page_speeds, :url_id, :unique => true
  end

  def self.down
    drop_table :page_speeds
  end
end