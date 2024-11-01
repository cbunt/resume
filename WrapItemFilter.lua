if FORMAT:match 'latex' or FORMAT:match 'markdown' then
    function OrderedList(items)
        for i, item in ipairs(items.content) do
            item[1].content:insert(1, pandoc.RawInline('latex', '\\BreakBox{'))
            item[1].content:insert(pandoc.RawInline('latex', '}'))
        end
        return items
    end
end
