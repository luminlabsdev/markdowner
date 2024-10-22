-- Variables

local Emoji = require(script.emoji)
local MarkdownPatterns = {
	"%*%*%*[%w%p%s]+%*%*%*",
	"%*%*[%w%p%s]+%*%*",
	"%*[%w%p%s]+%*",
	"~~[%w%p%s]+~~",
	"`[%w%p%s]+`",
	"__[%w%p%s]+__",
	"==[%w%p%s]+==",
	":[%w%p]+:"
}

local MarkdownSyntax = {
	"***",
	"**",
	"*",
	"~~",
	"`",
	"__",
	"==",
	":"
}

local RichTextSyntax = {
	{"<b><i>", "</i></b>"},
	{"<b>", "</b>"},
	{"<i>", "</i>"},
	{"<s>", "</s>"},
	{"<font family='rbxasset://fonts/families/RobotoMono.json'>", "</font>"},
	{"<u>", "</u>"},
	{"<font color='rgb(255,231,96)'>", "</font>"},
}
-- Functions

local function ToRichText(text: string, emojiColor: ("d" | "md" | "m" | "ml" | "l")?): string
	for index, pattern in MarkdownPatterns do
		if index == 8 then
			text = text:gsub(
				pattern,
				Emoji.GetEmoji(emojiColor or "") :: any
			)
			continue
		end
		text = text:gsub(
			pattern,
			function(result)
				return `{RichTextSyntax[index][1]}{result:gsub(MarkdownSyntax[index], "")}{RichTextSyntax[index][2]}`
			end
		)
	end
	return text
end

-- Module
return {
    ToRichText = ToRichText,
}
