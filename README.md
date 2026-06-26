# ⚙️ Running the Tool

## Option 1: EXE (Recommended)

1. Download the latest `PC-Diagnostic-Tool.exe` from the **Releases** page.
2. Right-click the file and select **Run as administrator** (recommended for complete system information).

### If Windows SmartScreen appears

If Windows displays **"Windows protected your PC"**:

1. Click **More info**.
2. Verify the publisher or file name matches the official release.
3. Click **Run anyway**.

> **Note:** This can happen because the application is new or unsigned.

### If Microsoft Defender quarantines the file

If you downloaded the tool from the official GitHub Releases page and Defender quarantines it:

1. Open **Windows Security**.
2. Go to **Virus & threat protection**.
3. Click **Protection history**.
4. Find the detection for the tool.
5. Verify it matches the official release you downloaded.
6. If you're confident it's the official file, you can restore it from quarantine.

---

## Option 2: BAT File

1. Download `PC-Diagnostic-Tool.bat`.
2. Double click on it or Right-click it and choose **Run as administrator**.
3. Follow the on-screen prompts.

> **Note:** Some antivirus products may warn about batch files because they can execute system commands. This tool uses built-in Windows commands (such as `systeminfo`, `PowerShell`, and `powercfg`) to collect diagnostic information.

---

## Verify the Download

To make sure you have the official version:

- Download only from this repository's **Releases** page.
- Compare the SHA-256 checksum (if provided) with the one listed in the release notes.
---
# 🧠 How to Read the Windows Memory Diagnostic Report

After running the Windows Memory Diagnostic Tool (`mdsched.exe`), Windows stores the test results in **Event Viewer**.

## Step 1: Open Event Viewer

- Press **Win + X**
- Select **Event Viewer**

## Step 2: Navigate to the Memory Diagnostic Logs

Go to:

```
Windows Logs
└── System
```

## Step 3: Find the Memory Diagnostic Result

In the **Actions** pane, click **Find...** (or press **Ctrl + F**).

Search for:

```
MemoryDiagnostics-Results
```

or

```
MemoryDiagnostic
```

Open the latest event.

## Step 4: View the Result

Select the **General** tab to read the summary.

You may also open the **Details** tab for more technical information.

---

# Understanding the Results

### ✅ No problems found

Example:

```
The Windows Memory Diagnostic tested the computer's memory and detected no errors.
```

**Meaning:** Your RAM passed the test.

---

### ❌ Hardware problems detected

Example:

```
The Windows Memory Diagnostic tested the computer's memory and detected hardware errors.
```

**Meaning:** One or more RAM modules may be faulty.

Recommended actions:

- Test each RAM stick individually.
- Reseat the memory modules.
- Clean the RAM contacts and slots.
- Replace the faulty module if errors persist.

---

# Notes

- The Windows Memory Diagnostic performs a basic memory test.
- For a more thorough test, consider using **MemTest86**, which performs multiple passes and can detect issues that Windows Memory Diagnostic may miss.

---

**Tip:** If you're buying a used RAM module, always run a memory test before relying on it for important work.
