package com.example.accessibilitybenchmark

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RichTextEditor() {
    var content by remember { mutableStateOf("") }
    var isBold by remember { mutableStateOf(false) }
    var isItalic by remember { mutableStateOf(false) }
    var isUnderline by remember { mutableStateOf(false) }
    var fontSize by remember { mutableStateOf(16f) }
    var textColor by remember { mutableStateOf(Color.Black) }
    var backgroundColor by remember { mutableStateOf(Color.White) }
    var alignment by remember { mutableStateOf(TextAlign.Start) }
    var showWordCount by remember { mutableStateOf(false) }
    var isUndoAvailable by remember { mutableStateOf(false) }
    var isRedoAvailable by remember { mutableStateOf(false) }
    var history by remember { mutableStateOf(listOf("")) }
    var historyIndex by remember { mutableStateOf(0) }
    var showFontSizePicker by remember { mutableStateOf(false) }
    var showColorPicker by remember { mutableStateOf(false) }
    var showInsertMenu by remember { mutableStateOf(false) }
    var colorPickerType by remember { mutableStateOf(ColorPickerType.TEXT) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Rich Text Editor") },
                actions = {
                    TextButton(onClick = { /* Save */ }) {
                        Text("Save")
                    }
                    TextButton(onClick = { /* Export */ }) {
                        Text("Export")
                    }
                    TextButton(onClick = { showWordCount = !showWordCount }) {
                        Text("Stats")
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // Toolbar
            Toolbar(
                isBold = isBold,
                isItalic = isItalic,
                isUnderline = isUnderline,
                fontSize = fontSize,
                textColor = textColor,
                backgroundColor = backgroundColor,
                alignment = alignment,
                isUndoAvailable = isUndoAvailable,
                isRedoAvailable = isRedoAvailable,
                onBoldClick = { isBold = !isBold },
                onItalicClick = { isItalic = !isItalic },
                onUnderlineClick = { isUnderline = !isUnderline },
                onFontSizeClick = { showFontSizePicker = true },
                onTextColorClick = { 
                    colorPickerType = ColorPickerType.TEXT
                    showColorPicker = true 
                },
                onBackgroundColorClick = { 
                    colorPickerType = ColorPickerType.BACKGROUND
                    showColorPicker = true 
                },
                onAlignmentClick = { alignment = it },
                onUndoClick = { 
                    if (historyIndex > 0) {
                        historyIndex--
                        content = history[historyIndex]
                        isUndoAvailable = historyIndex > 0
                        isRedoAvailable = true
                    }
                },
                onRedoClick = { 
                    if (historyIndex < history.size - 1) {
                        historyIndex++
                        content = history[historyIndex]
                        isUndoAvailable = true
                        isRedoAvailable = historyIndex < history.size - 1
                    }
                },
                onInsertClick = { showInsertMenu = true }
            )

            // Word Count Panel
            if (showWordCount) {
                WordCountPanel(
                    wordCount = content.trim().split("\\s+".toRegex()).filter { it.isNotEmpty() }.size,
                    charCount = content.length
                )
            }

            // Editor
            Editor(
                content = content,
                onContentChange = { newContent ->
                    content = newContent
                    val newHistory = history.take(historyIndex + 1) + newContent
                    history = newHistory
                    historyIndex = newHistory.size - 1
                    isUndoAvailable = historyIndex > 0
                    isRedoAvailable = historyIndex < newHistory.size - 1
                },
                isBold = isBold,
                isItalic = isItalic,
                isUnderline = isUnderline,
                fontSize = fontSize,
                textColor = textColor,
                backgroundColor = backgroundColor,
                alignment = alignment
            )
        }
    }

    // Font Size Picker
    if (showFontSizePicker) {
        FontSizePicker(
            selectedSize = fontSize,
            onSizeSelected = { size ->
                fontSize = size
                showFontSizePicker = false
            },
            onDismiss = { showFontSizePicker = false }
        )
    }

    // Color Picker
    if (showColorPicker) {
        ColorPicker(
            selectedColor = if (colorPickerType == ColorPickerType.TEXT) textColor else backgroundColor,
            colorType = colorPickerType,
            onColorSelected = { color ->
                if (colorPickerType == ColorPickerType.TEXT) {
                    textColor = color
                } else {
                    backgroundColor = color
                }
                showColorPicker = false
            },
            onDismiss = { showColorPicker = false }
        )
    }

    // Insert Menu
    if (showInsertMenu) {
        InsertMenu(
            onInsert = { type ->
                when (type) {
                    InsertType.IMAGE -> content += "\n[Image placeholder]\n"
                    InsertType.LINK -> content += "\n[Link placeholder]\n"
                    InsertType.TABLE -> content += "\n[Table placeholder]\n"
                    InsertType.LIST -> content += "\n• List item\n"
                }
                showInsertMenu = false
            },
            onDismiss = { showInsertMenu = false }
        )
    }
}

@Composable
fun Toolbar(
    isBold: Boolean,
    isItalic: Boolean,
    isUnderline: Boolean,
    fontSize: Float,
    textColor: Color,
    backgroundColor: Color,
    alignment: TextAlign,
    isUndoAvailable: Boolean,
    isRedoAvailable: Boolean,
    onBoldClick: () -> Unit,
    onItalicClick: () -> Unit,
    onUnderlineClick: () -> Unit,
    onFontSizeClick: () -> Unit,
    onTextColorClick: () -> Unit,
    onBackgroundColorClick: () -> Unit,
    onAlignmentClick: (TextAlign) -> Unit,
    onUndoClick: () -> Unit,
    onRedoClick: () -> Unit,
    onInsertClick: () -> Unit
) {
    LazyRow(
        modifier = Modifier
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surfaceVariant)
            .padding(vertical = 8.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        contentPadding = PaddingValues(horizontal = 16.dp)
    ) {
        // Undo/Redo Group
        item {
            ToolbarButton(
                icon = Icons.Default.Undo,
                enabled = isUndoAvailable,
                onClick = onUndoClick
            )
        }
        item {
            ToolbarButton(
                icon = Icons.Default.Redo,
                enabled = isRedoAvailable,
                onClick = onRedoClick
            )
        }
        item { ToolbarSeparator() }

        // Formatting Group
        item {
            ToolbarButton(
                icon = Icons.Default.FormatBold,
                selected = isBold,
                onClick = onBoldClick
            )
        }
        item {
            ToolbarButton(
                icon = Icons.Default.FormatItalic,
                selected = isItalic,
                onClick = onItalicClick
            )
        }
        item {
            ToolbarButton(
                icon = Icons.Default.FormatUnderlined,
                selected = isUnderline,
                onClick = onUnderlineClick
            )
        }
        item { ToolbarSeparator() }

        // Font Size Group
        item {
            ToolbarButton(
                text = "${fontSize.toInt()}pt",
                onClick = onFontSizeClick
            )
        }
        item {
            ColorButton(
                color = textColor,
                onClick = onTextColorClick
            )
        }
        item {
            ColorButton(
                color = backgroundColor,
                onClick = onBackgroundColorClick
            )
        }
        item { ToolbarSeparator() }

        // Alignment Group
        item {
            ToolbarButton(
                icon = Icons.Default.FormatAlignLeft,
                selected = alignment == TextAlign.Start,
                onClick = { onAlignmentClick(TextAlign.Start) }
            )
        }
        item {
            ToolbarButton(
                icon = Icons.Default.FormatAlignCenter,
                selected = alignment == TextAlign.Center,
                onClick = { onAlignmentClick(TextAlign.Center) }
            )
        }
        item {
            ToolbarButton(
                icon = Icons.Default.FormatAlignRight,
                selected = alignment == TextAlign.End,
                onClick = { onAlignmentClick(TextAlign.End) }
            )
        }
        item { ToolbarSeparator() }

        // Insert Group
        item {
            ToolbarButton(
                icon = Icons.Default.Add,
                onClick = onInsertClick
            )
        }
    }
}

@Composable
fun ToolbarButton(
    icon: androidx.compose.ui.graphics.vector.ImageVector? = null,
    text: String? = null,
    selected: Boolean = false,
    enabled: Boolean = true,
    onClick: () -> Unit
) {
    Box(
        modifier = Modifier
            .size(40.dp)
            .background(
                if (selected) MaterialTheme.colorScheme.primary.copy(alpha = 0.2f)
                else Color.Transparent,
                RoundedCornerShape(6.dp)
            )
            .clickable(enabled = enabled) { onClick() },
        contentAlignment = Alignment.Center
    ) {
        if (icon != null) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = if (enabled) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurface.copy(alpha = 0.5f)
            )
        } else if (text != null) {
            Text(
                text = text,
                style = MaterialTheme.typography.labelMedium,
                color = if (enabled) MaterialTheme.colorScheme.onSurface else MaterialTheme.colorScheme.onSurface.copy(alpha = 0.5f)
            )
        }
    }
}

@Composable
fun ColorButton(
    color: Color,
    onClick: () -> Unit
) {
    Box(
        modifier = Modifier
            .size(20.dp)
            .background(color, CircleShape)
            .border(1.dp, MaterialTheme.colorScheme.outline, CircleShape)
            .clickable { onClick() }
    )
}

@Composable
fun ToolbarSeparator() {
    Box(
        modifier = Modifier
            .width(1.dp)
            .height(32.dp)
            .background(MaterialTheme.colorScheme.outline)
    )
}

@Composable
fun WordCountPanel(
    wordCount: Int,
    charCount: Int
) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surfaceVariant)
            .padding(vertical = 8.dp),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = "Words: $wordCount | Characters: $charCount",
            style = MaterialTheme.typography.labelSmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}

@Composable
fun Editor(
    content: String,
    onContentChange: (String) -> Unit,
    isBold: Boolean,
    isItalic: Boolean,
    isUnderline: Boolean,
    fontSize: Float,
    textColor: Color,
    backgroundColor: Color,
    alignment: TextAlign
) {
    BasicTextField(
        value = content,
        onValueChange = onContentChange,
        modifier = Modifier
            .fillMaxSize()
            .background(backgroundColor)
            .padding(16.dp),
        textStyle = TextStyle(
            fontSize = fontSize.sp,
            color = textColor,
            fontWeight = if (isBold) FontWeight.Bold else FontWeight.Normal,
            fontStyle = if (isItalic) FontStyle.Italic else FontStyle.Normal,
            textDecoration = if (isUnderline) TextDecoration.Underline else TextDecoration.None,
            textAlign = alignment
        ),
        cursorBrush = SolidColor(MaterialTheme.colorScheme.primary),
        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Default),
        keyboardActions = KeyboardActions()
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FontSizePicker(
    selectedSize: Float,
    onSizeSelected: (Float) -> Unit,
    onDismiss: () -> Unit
) {
    val fontSizes = listOf(12f, 14f, 16f, 18f, 20f, 24f, 28f, 32f, 36f, 48f)

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Font Size") },
        text = {
            LazyColumn {
                items(fontSizes) { size ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { onSizeSelected(size) }
                            .padding(vertical = 8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "${size.toInt()}pt",
                            style = MaterialTheme.typography.bodyLarge.copy(fontSize = size.sp),
                            modifier = Modifier.weight(1f)
                        )
                        if (selectedSize == size) {
                            Icon(
                                Icons.Default.Check,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.primary
                            )
                        }
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ColorPicker(
    selectedColor: Color,
    colorType: ColorPickerType,
    onColorSelected: (Color) -> Unit,
    onDismiss: () -> Unit
) {
    val colors = listOf(
        Color.Black to "Black",
        Color.Gray to "Gray",
        Color.Red to "Red",
        Color.Orange to "Orange",
        Color.Yellow to "Yellow",
        Color.Green to "Green",
        Color.Blue to "Blue",
        Color.Magenta to "Purple",
        Color.Cyan to "Cyan"
    )

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(if (colorType == ColorPickerType.TEXT) "Text Color" else "Background Color") },
        text = {
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(colors.chunked(5)) { rowColors ->
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        rowColors.forEach { (color, name) ->
                            Box(
                                modifier = Modifier
                                    .weight(1f)
                                    .aspectRatio(1f)
                                    .background(color, CircleShape)
                                    .border(
                                        2.dp,
                                        if (selectedColor == color) MaterialTheme.colorScheme.primary else Color.Transparent,
                                        CircleShape
                                    )
                                    .clickable { onColorSelected(color) }
                            )
                        }
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun InsertMenu(
    onInsert: (InsertType) -> Unit,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Insert") },
        text = {
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(InsertType.values()) { type ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { onInsert(type) }
                            .padding(vertical = 8.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = when (type) {
                                InsertType.IMAGE -> Icons.Default.Image
                                InsertType.LINK -> Icons.Default.Link
                                InsertType.TABLE -> Icons.Default.TableChart
                                InsertType.LIST -> Icons.Default.List
                            },
                            contentDescription = null,
                            modifier = Modifier.size(32.dp)
                        )
                        Spacer(modifier = Modifier.width(16.dp))
                        Text(
                            text = type.name.lowercase().replaceFirstChar { it.uppercase() },
                            style = MaterialTheme.typography.bodyLarge
                        )
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

enum class ColorPickerType {
    TEXT, BACKGROUND
}

enum class InsertType {
    IMAGE, LINK, TABLE, LIST
}
